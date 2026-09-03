#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
sw-property-options — 从 Stormworks 可执行文件静态提取
「载具 XML <o> 属性名 → 游戏内下拉选项（有序）」映射。

原理（2026-09-03 实测验证）：
  1. 游戏定义 XML（rom/data/definitions）不含选项文本；唯一来源是
     stormworks64.exe（.rdata 字符串池 + .text 注册逻辑）。
  2. 选项串在 .rdata 字符串池中与所属属性键物理相邻（±0x800 内）。
  3. .text 中 RIP-relative lea(reg,[rip+disp32]) 对选项串的引用顺序
     == 游戏内下拉枚举顺序；同一属性选项的引用间隔 < 0x100 字节。
  4. 整型属性键的权威清单来自 "%lld 签名"：键串连续引用两次且其后
     紧跟 '%lld' 格式串（XML 反序列化宏展开）。

红线：游戏目录只读（open 'rb'），绝不写入；产出只写工作区。

用法：
  python extract_property_options.py                 # 全流程（提取+自检+JSON+MD）
  python extract_property_options.py --selftest      # 仅 golden 自检（退出码判定）
  python extract_property_options.py --exe <路径> --outdir <目录>
"""

import argparse
import bisect
import json
import os
import re
import struct
import sys
from datetime import datetime

# ---------------------------------------------------------------- 路径解析

def workspace_root():
    # 脚本位于 <WS>/技能库/sw-property-options/scripts/
    return os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "..", ".."))


def load_paths(ws):
    cfg = os.path.join(ws, "工作区导航", "路径配置.json")
    paths = {}
    if os.path.exists(cfg):
        with open(cfg, "r", encoding="utf-8") as fh:
            data = json.load(fh)
        for k, v in (data.get("paths") or data).items():
            if isinstance(v, str) and k.startswith("<"):
                paths[k.strip("<>")] = v
    return paths


# ---------------------------------------------------------------- PE 解析
# ⚠ 节表字段序：Name[8] | VirtualSize | VirtualAddress | SizeOfRawData | PointerToRawData
# ⚠ 一切地址 = ImageBase + VirtualAddress + 节内偏移（漏加 ImageBase 会全盘假阴性）

def parse_pe(f):
    hdr = f.read(0x400)
    if hdr[:2] != b"MZ":
        raise ValueError("not MZ")
    pe = struct.unpack_from("<I", hdr, 0x3C)[0]
    if hdr[pe:pe + 4] != b"PE\x00\x00":
        raise ValueError("not PE")
    nsec = struct.unpack_from("<H", hdr, pe + 6)[0]
    sizeopt = struct.unpack_from("<H", hdr, pe + 20)[0]
    opt = pe + 24
    magic = struct.unpack_from("<H", hdr, opt)[0]
    if magic == 0x20B:
        ib = struct.unpack_from("<Q", hdr, opt + 24)[0]
    elif magic == 0x10B:
        ib = struct.unpack_from("<I", hdr, opt + 28)[0]
    else:
        raise ValueError("bad optional header magic %#x" % magic)
    secs = []
    for i in range(nsec):
        o = opt + sizeopt + i * 40
        name = hdr[o:o + 8].rstrip(b"\x00").decode("ascii", "replace")
        vs, va, rs, pr = struct.unpack_from("<IIII", hdr, o + 8)
        secs.append((name, vs, va, rs, pr))
    return ib, secs


class Image:
    def __init__(self, path):
        self.path = path
        self.f = open(path, "rb")          # 只读
        self.ib, self.secs = parse_pe(self.f)
        self.secby = {s[0]: s for s in self.secs}

    def va2raw(self, v):
        for _n, vs, va, rs, pr in self.secs:
            if va <= v < va + max(vs, rs):
                return pr + (v - va)
        return None

    def read(self, va, n):
        r = self.va2raw(va)
        if r is None:
            return None
        self.f.seek(r)
        return self.f.read(n)

    def cstr(self, va, cap=96):
        b = self.read(va, cap)
        if b is None:
            return None
        z = b.find(b"\x00")
        if z <= 0:
            return None
        return b[:z].decode("ascii", "replace")

    def section(self, name):
        return self.secby[name]


def build_pool(img):
    """从 .rdata 提取全部明文字符串 → {VA: text}"""
    _n, vs, va, rs, pr = img.section(".rdata")
    img.f.seek(pr)
    blob = img.f.read(rs)
    pool = {}
    for m in re.finditer(rb"[ -~]{2,}\x00", blob):
        pool[img.ib + va + m.start()] = m.group()[:-1].decode("ascii", "replace")
    return pool


def scan_lea_refs(img, pool):
    """扫 .text：REX + 8D + modrm&0xC7==0x05（RIP-relative lea）→ [(codeVA, strVA, text)]"""
    _n, _vs, va, rs, pr = img.section(".text")
    img.f.seek(pr)
    text = img.f.read(rs)
    base = img.ib + va
    refs = []
    n = len(text) - 10
    for i in range(n):
        b = text[i]
        if b in (0x48, 0x49, 0x4C, 0x4D) and text[i + 1] == 0x8D and (text[i + 2] & 0xC7) == 0x05:
            disp = struct.unpack_from("<i", text, i + 3)[0]
            tgt = base + i + 7 + disp
            s = pool.get(tgt)
            if s is not None:
                refs.append((base + i, tgt, s))
    return refs


def parse_pdata(img):
    """x64 RUNTIME_FUNCTION 表 → 函数边界 [(beginVA,endVA)]（已排序）"""
    _n, _vs, _va, rs, pr = img.section(".pdata")
    img.f.seek(pr)
    pd = img.f.read(rs)
    funcs = []
    for i in range(0, len(pd) - 11, 12):
        b, e, _u = struct.unpack_from("<III", pd, i)
        if b:
            funcs.append((img.ib + b, img.ib + e))
    funcs.sort()
    return funcs


def func_index(funcs):
    starts = [x[0] for x in funcs]

    def func_of(va):
        i = bisect.bisect_right(starts, va) - 1
        if i >= 0 and funcs[i][0] <= va < funcs[i][1]:
            return i
        return None
    return func_of


# ---------------------------------------------------------------- 语义识别

RATIO_RE = re.compile(r"^-?\d{1,3}:-?\d{1,3}$")
KEY_RE = re.compile(r"^[a-z][a-z0-9_]{1,48}$")
CAP_RE = re.compile(r"^[A-Z0-9][A-Za-z0-9 ()/\.\+\-]{0,38}$")
FMT_RE = re.compile(r"%[#0\- +]*\d*(?:\.\d+)?[a-zA-Z]")
NODEY_RE = re.compile(r"\b(?:Node|Input|Output|Slot|Key|Button \d)\s*\d+$")


def is_option_like(s):
    if FMT_RE.search(s) or NODEY_RE.search(s):
        return False
    if RATIO_RE.match(s):
        return True
    if KEY_RE.match(s):
        return False                      # snake_case 是键/节点名，不是选项
    if CAP_RE.match(s) and len(s.split()) <= 3:
        return True
    return False


def norm_key(s):
    """'m_sweep_mode' → 'sweep mode'（供与标签 'Sweep Mode' 匹配）"""
    k = s.lower()
    if k.startswith("m_"):
        k = k[2:]
    return k.replace("_", " ")


def detect_enum_keys(refs):
    """%lld 签名：同一字符串连续引用两次、其后 0x80 内紧跟 '%lld'。"""
    keys = []
    seen = set()
    for i in range(len(refs) - 2):
        s0 = refs[i][2]
        if s0 in seen:
            continue
        if (KEY_RE.match(s0) and refs[i + 1][2] == s0
                and refs[i + 2][2] == "%lld"
                and refs[i + 2][0] - refs[i + 1][0] < 0x80):
            keys.append(s0)
            seen.add(s0)
    return keys


CLUSTER_GAP = 0x100        # 选项→选项引用间隔实测 < 0x70；跨属性 > 0x100
NEIGHBORHOOD = 0x800       # 选项串与属性键在字符串池中的最大距离
CLUSTER_MAX = 20           # 超过此成员数的簇视为混合大簇（UI 文本表），排除

# 不走 %lld 签名的已知枚举键（模块化引擎变速箱传动比；XML 实测取值上限 7 → ≥8 项）
EXTRA_KEYS = ["gear_ratio_1", "gear_ratio_2"]


def build_clusters(refs):
    """全部 option-like 引用按代码地址聚类（间隔 > CLUSTER_GAP 断开）。"""
    opt = sorted((ca, sva, s) for ca, sva, s in refs if is_option_like(s))
    clusters, cur = [], []
    for h in opt:
        if cur and h[0] - cur[-1][0] > CLUSTER_GAP:
            clusters.append(cur)
            cur = []
        cur.append(h)
    if cur:
        clusters.append(cur)
    out = []
    for c in clusters:
        n = len({sva for _ca, sva, _s in c})
        if 2 <= n <= CLUSTER_MAX:
            out.append(c)
    return out


def norm2(s):
    """字符串归一化：小写、去标点。"""
    return re.sub(r"[^a-z0-9 ]", "", s.lower()).strip()


def normkey(k):
    """键归一化为标签文本（'m_sweep_mode' → 'sweep mode'）。"""
    return " ".join(key_tokens(k))


def is_option_candidate(s):
    """放宽的选项候选：允许小写词，但排除图标/网格/贴图/句子/下划线键/超长。"""
    if not s or len(s) > 40:
        return False
    if FMT_RE.search(s) or "." in s:
        return False
    if "_" in s:
        return False
    if s.startswith(("graphics/", "meshes/", "inventory_", "main_ui", "data/",
                     "audio/", "missions/")) or s.endswith((".mesh", ".txtr", ".anim",
                     ".ogg", ".xml", ".png", ".dds", ".json", ".lua")):
        return False
    if KEY_RE.match(s) and "_" not in s and len(s) <= 2:
        return False   # 单/双字符保留模糊性（AND/OR/XOR/HE/AP 是合法选项）
    return True


def key_tokens(k):
    k = k.lower()
    for p in ("m_", "property_", "component_"):
        if k.startswith(p):
            k = k[len(p):]
    return [t for t in k.replace("_", " ").split()]


def is_subseq(lt, kt):
    it = iter(kt)
    return all(any(w == t for t in it) for w in lt)


def is_label_of(label_norm, key):
    """标签是否对应键：精确或词序子序列（water type ⊂ water component type）。"""
    lt = label_norm.split()
    kt = key_tokens(key)
    if lt == kt:
        return True
    return 2 <= len(lt) < len(kt) and is_subseq(lt, kt)


def build_label_nodes(label_keys, pool):
    """label_va -> key：池串归一化精确或词序子序列匹配某键（一个串只归一个键）。"""
    ktokens = {k: key_tokens(k) for k in label_keys}
    lab = {}
    for va, s in pool.items():
        if len(s) > 30 or "_" in s or "." in s:
            continue
        if s.startswith(("graphics/", "meshes/", "inventory_", "main_ui",
                         "data/", "audio/", "missions/")):
            continue
        ns = norm2(s)
        if not ns:
            continue
        lt = ns.split()
        for k, kt in ktokens.items():
            if lt == kt or (2 <= len(lt) < len(kt) and is_subseq(lt, kt)):
                lab.setdefault(va, k)
                break
    return lab


def build_runs(refs, label_nodes):
    """全引用序列 -> 以标签节点/非选项串/大间隔为边界的「标签-选项段」。

    返回 [{label_key, label_str, seq, vas, cas, ca0, ca1}]；seq 为去重后的
    选项串序列。原理：面板/注册函数中每个下拉列表 = 标签串 + 连续选项串
    （代码引用相邻 <=0x100），标签与选项在字符串池中同样相邻（注册在一起）。
    """
    runs = []
    cur, cur_label = [], None

    def close():
        nonlocal cur, cur_label
        if len(cur) >= 2:
            seq, seen, vas = [], set(), set()
            for _ca, sva, s in cur:
                vas.add(sva)
                if sva not in seen:
                    seen.add(sva)
                    seq.append(s)
            runs.append({"label_key": cur_label[0] if cur_label else None,
                         "label_str": cur_label[1] if cur_label else None,
                         "seq": seq, "vas": vas,
                         "cas": [ca for ca, _sv, _s in cur],
                         "ca0": cur[0][0], "ca1": cur[-1][0]})
        cur, cur_label = [], None

    prev_ca = None
    for ca, sva, s in sorted(refs):
        if prev_ca is not None and ca - prev_ca > CLUSTER_GAP:
            close()
        if sva in label_nodes:
            close()
            cur_label = (label_nodes[sva], s)
        elif not is_option_like(s):
            close()
        else:
            cur.append((ca, sva, s))
        prev_ca = ca
    close()
    return runs


def extract_all(keys, pool, refs, func_of, label_keys):
    """返回 {key: {"label":…, "candidates":[…]}}。三类锚定候选：
    ① label-run：标签节点后的连续选项段（代码序）；② key@func / pool-min；
    ③ label-nb：标签池邻域(±0x600)内的选项候选，按代码引用地址排序。"""
    funcs_keys = {}
    refs_by_va = {}
    for ca, sva, s in refs:
        fi = func_of(ca)
        if fi is not None:
            funcs_keys.setdefault(fi, set()).add(s)
        refs_by_va.setdefault(sva, []).append(ca)
    key_vas = {}
    for va, s in pool.items():
        if s in keys:
            key_vas.setdefault(s, []).append(va)

    label_nodes = build_label_nodes(label_keys, pool)
    label_str_by_key = {}
    for va, k in label_nodes.items():
        label_str_by_key.setdefault(k, pool[va])
    runs = build_runs(refs, label_nodes)
    for r in runs:
        r["fis"] = {func_of(ca) for ca in r["cas"]} - {None}

    props = {}
    for k in keys:
        normK = normkey(k)
        cands = []
        # ① label-run / key@func / pool-min
        for kv in key_vas.get(k, []):
            for r in runs:
                dists = [abs(sv - kv) for sv in r["vas"]]
                dmin = min(dists)
                meand = sum(dists) / len(dists)
                score, why = 0, []
                if r["label_key"] == k and dmin <= 0x400:
                    score += 6
                    why.append("label-run(%s)" % (r["label_str"] or ""))
                if any(k in funcs_keys.get(fi, ()) for fi in r["fis"]):
                    score += 3
                    why.append("key@func")
                if dmin <= 0x400:
                    score += 2
                    why.append("pool-min=%#x" % dmin)
                elif score == 0:
                    continue
                seq = tuple(s for s in r["seq"] if norm2(s) != normK)
                if len(seq) < 2:
                    continue
                cands.append({"score": score, "why": "+".join(why), "seq": list(seq),
                              "meand": meand,
                              "evidence": "%s-%s" % (hex(r["ca0"]), hex(r["ca1"]))})
        # ③ label-nb：标签池邻域候选
        label_strs = {pool[va] for va in label_nodes}
        for lva, lk in label_nodes.items():
            if lk != k:
                continue
            lstr = pool[lva]
            if not lstr or not lstr[0].islower():
                continue   # 仅小写部件区标签（显示标签邻域含其它属性标签，不可靠）
            nb = [(va, s) for va, s in pool.items()
                  if abs(va - lva) <= 0x600 and is_option_candidate(s)
                  and norm2(s) != normK and s not in label_strs]
            if len(nb) < 2 or len(nb) > 14:
                continue
            order = sorted(nb, key=lambda t: min(refs_by_va.get(t[0], [1 << 60])))
            seq, seen = [], set()
            for _va, s in order:
                if s not in seen:
                    seen.add(s)
                    seq.append(s)
            if len(seq) < 2 or len(seq) > 14:
                continue
            cands.append({"score": 4, "why": "label-nb", "seq": seq,
                          "meand": 0, "evidence": "pool@%s" % hex(lva)})
        cands.sort(key=lambda c: (-c["score"], c["meand"]))
        props[k] = {"label": label_str_by_key.get(k), "candidates": cands}
    return props


# ---------------------------------------------------------------- golden 自检

GOLDEN = {
    "m_sweep_mode": ["Static", "Clockwise", "Anticlockwise", "Sweep", "Manual"],
    "gear_ratio": ["1:1", "1:2", "1:4", "1:8", "1:16", "1:32"],
}


def run_selftest(result):
    fails = []
    props = result.get("properties", {})
    for k, expect in GOLDEN.items():
        got = (props.get(k) or {}).get("options")
        if got != expect:
            fails.append("%s: expect %r got %r" % (k, expect, got))
    return fails


# ---------------------------------------------------------------- XML 交叉验证

O_TAG_RE = re.compile(r"<o\s+([^>]*)>")
ATTR_RE = re.compile(r'([a-zA-Z_][a-zA-Z0-9_]*)="(-?[\d.]+)"')
C_RE = re.compile(r'<c d="([^"]+)"')


def xml_validate(save_dir):
    """扫存档载具 → {attr: {"components": [...], "values": [...]}}（只收 int 值）"""
    comp_use, val_use = {}, {}
    files = []
    if save_dir and os.path.isdir(save_dir):
        files = sorted(os.path.join(save_dir, x) for x in os.listdir(save_dir)
                       if x.lower().endswith(".xml"))
    for path in files:
        try:
            with open(path, "r", encoding="utf-8", errors="replace") as fh:
                raw = fh.read()
        except OSError:
            continue
        for cm in C_RE.finditer(raw):
            d = cm.group(1)
            seg = raw[cm.end():cm.end() + 4000]
            om = O_TAG_RE.search(seg)
            if not om:
                continue
            for am in ATTR_RE.finditer(om.group(1)):
                attr, val = am.group(1), am.group(2)
                comp_use.setdefault(attr, set()).add(d)
                try:
                    val_use.setdefault(attr, set()).add(int(float(val)))
                except ValueError:
                    pass
    return {a: {"components": sorted(comp_use.get(a, [])),
                "values": sorted(val_use.get(a, []))}
            for a in set(comp_use) | set(val_use)}


def apply_validation(properties, xml_usage):
    """把 XML 实测并入 properties：components、取值越界降级、无实测降级。"""
    for attr, prop in properties.items():
        u = xml_usage.get(attr)
        if not u:
            # 无载具实测：golden 键与全比值簇保留，其余（含 auto）一律降级待人工
            if prop.get("options") and attr not in GOLDEN:
                if not all(RATIO_RE.match(s) for s in prop["options"]):
                    prop["verified"] = "todo"
                    prop["note"] = (prop.get("note", "") +
                                    " 无载具实测部件且非比值簇，降级待人工").strip()
                    prop["candidates"] = prop.pop("options")
                    prop["n"] = 0
            continue
        prop["components"] = u["components"]
        if prop.get("options"):
            n = len(prop["options"])
            bad = [v for v in u["values"] if v < 0 or v >= n]
            if bad:
                prop["verified"] = "todo"
                prop["note"] = (prop.get("note", "") +
                                " XML 实测取值越界 %r（n=%d）" % (bad, n)).strip()
            elif prop["verified"] == "auto":
                prop["note"] = (prop.get("note", "") +
                                " XML 实测取值均落在 [0,%d)" % n).strip()


# ---------------------------------------------------------------- 主流程

def main(argv=None):
    ap = argparse.ArgumentParser(description="Extract Stormworks property option enums")
    ap.add_argument("--exe", help="stormworks64.exe 路径（默认从 路径配置.json 解析）")
    ap.add_argument("--outdir", help="输出目录（默认 <WS>/数据库/方块数据/数据）")
    ap.add_argument("--selftest", action="store_true", help="仅运行 golden 自检")
    ap.add_argument("--no-markdown", action="store_true", help="不生成 Markdown 知识册")
    args = ap.parse_args(argv)

    ws = workspace_root()
    paths = load_paths(ws)
    exe = args.exe or (paths.get("SW_GAME") and os.path.join(paths["SW_GAME"], "stormworks64.exe"))
    if not exe or not os.path.exists(exe):
        print("找不到 stormworks64.exe（--exe 或 路径配置.json 的 SW_GAME）", file=sys.stderr)
        return 3
    save_dir = paths.get("SW_SAVE") and os.path.join(paths["SW_SAVE"], "data", "vehicles")

    img = Image(exe)
    pool = build_pool(img)
    refs = scan_lea_refs(img, pool)
    keys = detect_enum_keys(refs)
    keys += [k for k in EXTRA_KEYS if k not in keys]
    print("字符串池 %d 条；代码引用 %d 条；枚举键 %d 个（%%lld 签名 %d + 人工扩展 %d）"
          % (len(pool), len(refs), len(keys),
             len(keys) - len([k for k in EXTRA_KEYS if k in keys]),
             len([k for k in EXTRA_KEYS if k in keys])))

    func_of = func_index(parse_pdata(img))
    xml_usage = xml_validate(save_dir)

    # 标签字典：枚举键 + 载具 XML 中出现过的全部属性名（含标量键，用于分割段）
    label_keys = list(keys) + [a for a in xml_usage if a not in keys]
    raw = extract_all(keys, pool, refs, func_of, label_keys)

    # 候选选择：n 须 > 该键 XML 实测最大值；再按锚定分定级
    properties = {}
    for k in keys:
        cand_list = raw[k]["candidates"]
        u = xml_usage.get(k)
        vals = u["values"] if u else []
        vmax = max(vals) if vals else None
        eligible = [c for c in cand_list if vmax is None or len(c["seq"]) > vmax]
        pick = eligible[0] if eligible else None
        if pick is None and cand_list:
            pick = cand_list[0]
        prop = {"label": raw[k]["label"]}
        if pick:
            prop.update({"options": pick["seq"], "n": len(pick["seq"]),
                         "evidence": pick["evidence"], "note": "锚定:" + pick["why"],
                         "alt_candidates": [c["seq"] for c in cand_list
                                            if c is not pick and c["seq"] != pick["seq"]][:3]})
            anchored = "label-run" in pick["why"] or "key@func" in pick["why"]
            if k in GOLDEN and prop["options"] == GOLDEN[k]:
                prop["verified"] = "auto"
                prop["note"] += "; golden 校验通过"
            elif anchored:
                prop["verified"] = "auto" if (vmax is None or len(prop["options"]) > vmax) else "partial"
                if prop["verified"] == "partial":
                    prop["note"] += "; n 与实测最大值冲突"
            else:
                prop["verified"] = "partial"
                prop["note"] += "; 仅池距锚定，建议游戏内复核"
            if len(prop["options"]) >= 16 and prop["verified"] == "auto":
                prop["verified"] = "partial"
                prop["note"] += "; 大簇(>=16项)谨慎采信"
            if prop.get("alt_candidates"):
                prop["note"] += "; 存在%d个异序候选" % len(prop["alt_candidates"])
        else:
            prop.update({"options": None, "n": 0, "verified": "todo",
                         "evidence": "", "note": "无锚定段（非下拉或需人工复核）"})
        properties[k] = prop

    apply_validation(properties, xml_usage)

    manual = {}
    mpath = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..",
                         "数据库", "方块数据", "数据", "property_options_manual.json")
    if os.path.exists(mpath):
        with open(mpath, "r", encoding="utf-8") as fh:
            manual = json.load(fh)
        for k, v in manual.items():
            if k.startswith("_"):
                continue
            if k not in properties:
                properties[k] = {}
            cur = properties[k]
            cur.update({kk: vv for kk, vv in v.items() if kk not in ("options",) or "options" not in cur})
            if "options" in v:
                cur["options"] = v["options"]
                cur["n"] = len(v["options"])
            cur["verified"] = v.get("verified", "curated")
            cur["note"] = v.get("note", "")
            cur["label"] = v.get("label", cur.get("label"))
            cur["evidence"] = v.get("evidence", cur.get("evidence", ""))
            cur["manual"] = True

    result = {
        "_meta": {
            "generated": datetime.now().isoformat(timespec="seconds"),
            "exe": exe,
            "method": "text-lea-code-ref-order (见 SKILL.md)",
            "golden": GOLDEN,
            "enum_keys_total": len(keys),
            "resolved": sum(1 for p in properties.values() if p.get("options")),
        },
        "properties": properties,
        "xml_usage": xml_usage,
    }

    if args.selftest:
        fails = run_selftest(result)
        if fails:
            for x in fails:
                print("GOLDEN FAIL:", x, file=sys.stderr)
            return 1
        print("GOLDEN PASS: m_sweep_mode / gear_ratio")
        return 0

    outdir = args.outdir or os.path.join(ws, "数据库", "方块数据", "数据")
    os.makedirs(outdir, exist_ok=True)
    jpath = os.path.join(outdir, "property_options.json")
    with open(jpath, "w", encoding="utf-8") as fh:
        json.dump(result, fh, ensure_ascii=False, indent=1)
    print("已写", jpath)

    fails = run_selftest(result)
    for x in fails:
        print("GOLDEN FAIL:", x, file=sys.stderr)
    if fails:
        return 1

    if not args.no_markdown:
        mpath = os.path.join(outdir, "property_options_自动提取.md")
        write_markdown(mpath, result)
        print("已写", mpath)
    return 0


def write_markdown(path, result):
    props = result["properties"]
    usage = result.get("xml_usage", {})
    lines = [
        "# 部件选项枚举（自动提取自游戏可执行文件）",
        "",
        "> 生成：%s ｜ 方法：`.text` 代码引用顺序 = 下拉枚举顺序（详见 技能库/sw-property-options/SKILL.md）" % result["_meta"]["generated"],
        "> Golden 校验：m_sweep_mode / gear_ratio 已强制比对通过。",
        "> `verified`：auto=自动提取且无矛盾；partial=存在歧义；todo=未解析或需游戏内复核。",
        "",
        "## 已解析（有选项序列）",
        "",
        "| XML 属性 | UI 标签 | 选项（0→n-1） | n | verified | 载具实测部件 |",
        "| --- | --- | --- | --- | --- | --- |",
    ]
    resolved = [(k, p) for k, p in sorted(props.items()) if p.get("options")]
    for k, p in resolved:
        comps = ", ".join((usage.get(k, {}) or {}).get("components", [])[:4]) or "—"
        opts = " / ".join("%d=%s" % (i, s) for i, s in enumerate(p["options"]))
        label = p.get("label") or "—"
        lines.append("| `%s` | %s | %s | %d | %s | %s |" % (k, label, opts, p["n"], p["verified"], comps))
    lines += ["", "## 未解析（整型属性但邻域无选项簇）", ""]
    for k, p in sorted(props.items()):
        if not p.get("options"):
            lines.append("- `%s` — %s" % (k, p.get("note", "")))
    lines += ["", "## 载具 XML 实测属性清单（%d 项）" % len(usage), ""]
    for a in sorted(usage):
        u = usage[a]
        lines.append("- `%s`：部件 %s；实测值 %s"
                     % (a, ", ".join(u["components"][:6]) or "—",
                        u["values"][:12] if u["values"] else "—"))
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")


if __name__ == "__main__":
    sys.exit(main())
