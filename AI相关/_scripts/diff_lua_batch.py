#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""本批 vs 主语料哈希差分：剔除已在主语料（_提取暂存/*.lua）出现过的脚本。
口径统一：剥离提取头部两行（-- source: / -- url:）后再取 MD5。只读。"""
import os, sys, io, hashlib

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
BASE = r"D:\STORMWORKS\AI相关\_提取暂存"
# 用法：diff_lua_batch.py [--] <id,id,...> [--dir _r4]
#   ids 位置参数与 "--" 占位兼容（-- 后可接 id 列表）；--dir 指定批次子目录，默认 _new
_a = sys.argv[1:]
_dir = "_new"
if "--dir" in _a:
    _k = _a.index("--dir")
    if len(_a) > _k + 1:
        _dir = _a[_k + 1]
    _a = _a[:_k] + _a[_k + 2:]
NEW = _dir if os.path.isdir(_dir) else os.path.join(BASE, _dir)
_pos = [x for x in _a if x not in ("--", "-")]
IDS = [x for x in _pos[0].split(",") if x] if _pos else []


def body_of(p):
    t = open(p, encoding="utf-8", errors="ignore").read()
    return t.split("\n", 2)[2] if t.startswith("-- source") else t


main = {}
for fn in os.listdir(BASE):
    if fn.endswith(".lua"):
        main[hashlib.md5(body_of(os.path.join(BASE, fn)).encode("utf-8")).hexdigest()] = fn
for d in ("_big",):
    p = os.path.join(BASE, d)
    if os.path.isdir(p):
        for fn in os.listdir(p):
            if fn.endswith(".lua"):
                main[hashlib.md5(body_of(os.path.join(p, fn)).encode("utf-8")).hexdigest()] = d + "/" + fn

print("主语料唯一脚本 %d 个\n" % len(main))
new_only, dup = [], []
seen = {}
for fn in sorted(os.listdir(NEW)):
    if not fn.endswith(".lua"):
        continue
    if IDS and fn.split("_")[0] not in IDS:
        continue
    b = body_of(os.path.join(NEW, fn))
    h = hashlib.md5(b.encode("utf-8")).hexdigest()
    if h in seen:
        continue
    seen[h] = fn
    if h in main:
        dup.append((fn, main[h]))
    else:
        new_only.append((fn, len(b)))

# 重复 ≠ 可以跳过：若这段脚本在主语料里归属的作品**还没写成例题**，
# 跳过就等于永久丢掉这段知识。故对每个重复项标注其归属作品的学习状态。
try:
    import ws_reference as _ref
    _idx = _ref.load_index(allow_build=False)
except Exception:
    _idx = {}


def owner_state(main_fn):
    """主语料文件名形如 <tid>_<kind>_<n>.lua 或 _big/<tid>_... ；取 tid 查已学习索引。"""
    tid = main_fn.split("/")[-1].split("_")[0]
    e = _idx.get(tid)
    return tid, bool(e and e.get("learned"))


safe, need = [], []
for fn, m in dup:
    tid, ok = owner_state(m)
    (safe if ok else need).append((fn, m, tid))

print("本批唯一 %d → 主语料已存在 %d / 全新 %d\n" % (len(seen), len(dup), len(new_only)))
print("== 全新（优先精读）==")
for fn, n in sorted(new_only, key=lambda x: -x[1]):
    print("  %6dc  %s" % (n, fn))

print("\n== 重复·归属作品已学习（可安全跳过，不占精读预算）==")
for fn, m, tid in sorted(safe):
    print("  %-34s == %s  [已学习 %s]" % (fn, m, tid))
if not safe and not dup:
    print("  （无）")

print("\n== ⚠ 重复·但归属作品尚未写成例题（必须补学，不可跳过）==")
for fn, m, tid in sorted(need):
    print("  %-34s == %s  [未学习 %s]" % (fn, m, tid))
if not need:
    print("  （无）")
else:
    print(f"\n  → 这 {len(need)} 段虽然内容重复，但源作品还没出例题："
          f"挑其中最具代表性的 1~3 段精读并写例题即可，其余可跳过。")
