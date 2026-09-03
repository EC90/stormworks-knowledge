#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
build_glossary.py — 由 Stormworks 汉化补丁 language.tsv 生成「AI 友好」的中英对照表。

源数据格式（4 列，Tab 分隔，UTF-8）：
    id \t description \t en \t local
  · id 为空      → 游戏内 UI / 提示 / 剧情文案
  · id 为 def_*  → 部件(方块/组件)的名称、描述、短描述、逻辑节点标签

产出（默认输出到 汉化相关/ 目录）：
    README_中英对照表.md        入口说明与 AI 使用规则
    常用术语速查.md             核心概念 + 部件名称速查
    词典/部件_<模块>.md          按 16 个模块拆分的部件中英对照
    词典/界面与文案.md           按主题分组的 UI 文案对照
    数据/sw_glossary.jsonl      全量条目（机器可读，每行一条）
    数据/sw_glossary.tsv        全量条目（Excel/人工校对用）
    数据/sw_core_dict.json      去重后的 EN -> ZH 快查字典
    数据/待补翻清单.txt          尚未翻译的条目
    数据/_snapshot.jsonl        用于下次增量比对的快照

用法：
    python build_glossary.py                       # 默认源=创意工坊 language.tsv
    python build_glossary.py <源.tsv> <输出目录>
"""

import csv
import io
import json
import os
import re
import sys
from collections import Counter, OrderedDict, defaultdict
from datetime import datetime

# ---------------------------------------------------------------- 默认路径

# 路径随机器而变（Steam 库盘符、汉化补丁的工坊物品 ID 都不固定），由 sw_locate 解析，
# 顺序：环境变量 SW_LANG_TSV / SW_WORKSHOP / STEAM_LIB → 工作区导航\路径配置.json
#       → 内置旧值（存在才用） → 工作区导航\脚本\sw_paths.py 全盘探测 → 兜底
if __package__:
    from . import sw_locate
else:
    sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__))))
    import sw_locate

DEFAULT_SRC = sw_locate.resolve_language_tsv()
DEFAULT_OUT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GITHUB_RAW = "https://raw.githubusercontent.com/BKN46/stormworks-translate-chn/main/SimplifiedChinese.tsv"

# ------------------------------------------------- 部件族 -> (模块, 中文名)
# 由 def_<family>_... 的第二段派生，共 147 个族
FAMILY_MAP = {
    # ---- 结构建材 ----
    "01": ("结构建材", "基础方块"), "02": ("结构建材", "基础方块"),
    "03": ("结构建材", "基础方块"), "04": ("结构建材", "基础方块"),
    "05": ("结构建材", "基础方块"), "06": ("结构建材", "基础方块"),
    "07": ("结构建材", "基础方块"), "08": ("结构建材", "基础方块"),
    "09": ("结构建材", "基础方块"), "10": ("结构建材", "基础方块"),
    "11": ("结构建材", "基础方块"), "12": ("结构建材", "基础方块"),
    "13": ("结构建材", "基础方块"), "14": ("结构建材", "基础方块"),
    "15": ("结构建材", "基础方块"),
    "window": ("结构建材", "窗户"), "door": ("结构建材", "门"),
    "hatch": ("结构建材", "舱盖"), "railing": ("结构建材", "栏杆"),
    "stair": ("结构建材", "楼梯"), "ladder": ("结构建材", "梯子"),
    "sign": ("结构建材", "标牌"), "flag": ("结构建材", "旗帜"),
    "buoyancy": ("结构建材", "浮力块"), "keel": ("结构建材", "龙骨"),
    "handle": ("结构建材", "把手"), "friction": ("结构建材", "摩擦"),
    "solid": ("结构建材", "实心块"),
    # ---- 引擎与动力 ----
    "engine": ("引擎与动力", "引擎"), "motor": ("引擎与动力", "马达"),
    "jet": ("引擎与动力", "喷气引擎"), "rotor": ("引擎与动力", "旋翼"),
    "propeller": ("引擎与动力", "螺旋桨"), "fan": ("引擎与动力", "风扇"),
    "turbine": ("引擎与动力", "涡轮"), "turbocharger": ("引擎与动力", "涡轮增压器"),
    "intercooler": ("引擎与动力", "中冷器"), "heat": ("引擎与动力", "散热/加热"),
    "heater": ("引擎与动力", "加热器"), "furnace": ("引擎与动力", "熔炉"),
    "steam": ("引擎与动力", "蒸汽"), "modular": ("引擎与动力", "模块化引擎"),
    "rcs": ("引擎与动力", "RCS 推进器"), "large": ("引擎与动力", "大型"),
    "huge": ("引擎与动力", "巨型"), "heavy": ("引擎与动力", "重型"),
    "giga": ("引擎与动力", "巨型"), "small": ("引擎与动力", "小型"),
    "trans": ("引擎与动力", "传动/变速箱"), "torque": ("引擎与动力", "扭矩"),
    # ---- 流体系统 ----
    "fluid": ("流体系统", "流体"), "liquid": ("流体系统", "液体"),
    "water": ("流体系统", "水"), "oil": ("流体系统", "油"),
    "gas": ("流体系统", "气体"), "air": ("流体系统", "空气"),
    "hydrogen": ("流体系统", "氢气"), "relief": ("流体系统", "泄压阀"),
    "cryo": ("流体系统", "低温制冷"), "pump": ("流体系统", "泵"),
    # ---- 电力与能源 ----
    "electric": ("电力与能源", "电力"), "battery": ("电力与能源", "电池"),
    "generator": ("电力与能源", "发电机"), "solar": ("电力与能源", "太阳能"),
    # ---- 逻辑与电路 ----
    "gate": ("逻辑与电路", "逻辑门"), "data": ("逻辑与电路", "数据"),
    "microprocessor": ("逻辑与电路", "微处理器"), "physics": ("逻辑与电路", "物理辅助"),
    "no": ("逻辑与电路", "保活/占位"), "button": ("逻辑与电路", "按钮开关"),
    # ---- 传感器与探测 ----
    "radar": ("传感器与探测", "雷达"), "sonar": ("传感器与探测", "声呐"),
    "camera": ("传感器与探测", "摄像头"), "gyro": ("传感器与探测", "陀螺仪"),
    "gyroscopic": ("传感器与探测", "陀螺"), "distance": ("传感器与探测", "测距"),
    "altimeter": ("传感器与探测", "高度表"), "barometer": ("传感器与探测", "气压计"),
    "humidity": ("传感器与探测", "湿度"), "temperature": ("传感器与探测", "温度"),
    "pressure": ("传感器与探测", "压力"), "radiation": ("传感器与探测", "辐射"),
    "rain": ("传感器与探测", "降雨"), "wind": ("传感器与探测", "风力"),
    "angular": ("传感器与探测", "角速度"), "rotation": ("传感器与探测", "旋转"),
    "rotating": ("传感器与探测", "旋转件"), "impact": ("传感器与探测", "碰撞"),
    "player": ("传感器与探测", "玩家"), "viewing": ("传感器与探测", "观瞄"),
    "artificial": ("传感器与探测", "姿态仪表"), "astronomy": ("传感器与探测", "天文"),
    "azimuth": ("传感器与探测", "方位角"),
    # ---- 显示与控制 ----
    "monitor": ("显示与控制", "显示器"), "indicator": ("显示与控制", "指示灯"),
    "gauge": ("显示与控制", "仪表"), "instrument": ("显示与控制", "仪器"),
    "dial": ("显示与控制", "拨盘"), "digital": ("显示与控制", "数码"),
    "clock": ("显示与控制", "时钟"), "speaker": ("显示与控制", "扬声器"),
    "buzzer": ("显示与控制", "蜂鸣器"), "siren": ("显示与控制", "警报器"),
    "foghorn": ("显示与控制", "雾笛"), "mic": ("显示与控制", "麦克风"),
    "searchlight": ("显示与控制", "探照灯"), "map": ("显示与控制", "地图"),
    # ---- 武器与军用 ----
    "gun": ("武器与军用", "枪械/炮"), "warhead": ("武器与军用", "弹头"),
    "laser": ("武器与军用", "激光"), "watercannon": ("武器与军用", "水炮"),
    "flare": ("武器与军用", "干扰弹"),
    # ---- 通信与导航 ----
    "rx": ("通信与导航", "无线电"), "transponder": ("通信与导航", "应答器"),
    "gps": ("通信与导航", "GPS"), "compass": ("通信与导航", "罗盘"),
    # ---- 结构与气动(飞行) ----
    "wing": ("结构与气动", "机翼"), "tail": ("结构与气动", "尾翼"),
    "rudder": ("结构与气动", "方向舵"), "control": ("结构与气动", "控制面"),
    "aircraft": ("结构与气动", "航空"),
    # ---- 工业加工 ----
    "separator": ("工业加工", "分离器"), "distillation": ("工业加工", "蒸馏"),
    "desalinator": ("工业加工", "海水淡化"), "electrolyser": ("工业加工", "电解"),
    "catalytic": ("工业加工", "催化"), "slurry": ("工业加工", "矿浆"),
    # ---- 载具与交通 ----
    "wheel": ("载具与交通", "车轮"), "tyre": ("载具与交通", "轮胎"),
    "train": ("载具与交通", "火车"), "ski": ("载具与交通", "滑橇"),
    "vehicle": ("载具与交通", "载具"), "landing": ("载具与交通", "起落架"),
    "parachute": ("载具与交通", "降落伞"), "scoop": ("载具与交通", "进气/进水口"),
    # ---- 座椅与载人 ----
    "seat": ("座椅与载人", "座椅"), "passenger": ("座椅与载人", "乘客"),
    # ---- 机械与传动 ----
    "connector": ("机械与传动", "连接器"), "magall": ("机械与传动", "磁吸头"),
    "rope": ("机械与传动", "绳索"), "winch": ("机械与传动", "绞盘"),
    "multibody": ("机械与传动", "多体物理"), "linear": ("机械与传动", "线性作动"),
    # ---- 任务与货物 ----
    "inventory": ("任务与货物", "货舱/库存"), "mineral": ("任务与货物", "矿物"),
    "fish": ("任务与货物", "鱼类"), "lobster": ("任务与货物", "龙虾"),
}

MODULE_ORDER = [
    "结构建材", "引擎与动力", "流体系统", "电力与能源", "机械与传动",
    "逻辑与电路", "传感器与探测", "显示与控制", "通信与导航", "武器与军用",
    "结构与气动", "载具与交通", "座椅与载人", "工业加工", "任务与货物", "其他部件",
]

# ------------------------------------------- UI 文案主题规则（按优先级匹配）
UI_RULES = [
    ("微控制器与 Lua", r"(?i)(\blua\b|\bscript\b|microcontroller|onTick|onDraw|composite|\bnode\b|\bnil\b|input\.|output\.)"),
    ("微控制器与 Lua", r"(?i)^(?:sin|cos|tan|asin|acos|atan2?|abs|min|max|clamp|sqrt|pow|floor|ceil|round)\b"),
    ("任务与剧情", r"(?i)(mission|objective|quest|deliver|reward|rescue|survivor|distress|cargo run)"),
    ("创意工坊与上传", r"(?i)(workshop|upload|publish|subscribe|\baddon)"),
    ("多人游戏与服务器", r"(?i)(\bserver\b|multiplayer|\blobby\b|\bhost\b|dedicated|whitelist|\bbanned\b|steam\b)"),
    ("地形与环境", r"(?i)(island|volcano|\brock|beach|cave|mountain|\blake\b|river|observatory|harbour|harbor|dock|formation|seabed|glacier|desert|swamp|forest|\bpeak\b|\bbay\b|coast|\breef\b)"),
    ("生物与角色", r"(?i)(\bcrab|\bfish|herring|lobster|shark|whale|\bbird|zombie|corgi|\bcat\b|\bdog\b|eyebrow|hoodie|life jacket|beret|outfit|hairstyle)"),
    ("按键与控制", r"(?i)(keybind|\bbind\b|crouch|swim down|swim up|\bjump\b|sprint|prone|\blean\b|pause/unpause|\[\$\[)"),
    ("图形与设置", r"(?i)(resolution|graphics|vsync|anti-?alias|ssao|fxaa|taa|shadow|quality|\bfps\b|refresh|gamma|\bvolume\b|\baudio\b|brightness|\bgpu\b|vendor|fullscreen|sensitivity)"),
    ("警告与错误", r"(?i)(\berror|\bfail|invalid|missing|too many|not enough|\bwarning|unable|cannot|corrupt|timeout|disconnect)"),
    ("编辑器与建造", r"(?i)(selection|\bpaste\b|\bcopy\b|\bundo\b|\bredo\b|eraser|wedge|\bpaint\b|subassembly|workbench|\bmirror\b|clipboard|\bgrid\b)"),
    ("载具与工坊", r"(?i)(\bvehicle|\bboat\b|\bplane\b|heli|\bcar\b|truck|spawn|despawn|trailer)"),
    ("物理与机制", r"(?i)(buoyancy|\bmass\b|weight|\bdrag\b|\blift\b|thrust|torque|\bforce\b|gravity|velocity|airspeed|altitude|\bfuel\b|temperature|pressure)"),
    ("教程与提示", r"(?i)(finally|first,|next,|tutorial|\btip\b|\bhint\b|connect the)"),
]
UI_TOPIC_ORDER = [
    "主菜单与存档", "多人游戏与服务器", "编辑器与建造", "微控制器与 Lua",
    "载具与工坊", "创意工坊与上传", "任务与剧情", "地形与环境",
    "生物与角色", "按键与控制", "图形与设置", "物理与机制",
    "警告与错误", "教程与提示", "通用界面",
]

# ------------------------------------------------------- 人工整理的核心概念
CORE_CONCEPTS = [
    ("Stormworks: Build and Rescue", "风暴工程：建造与救援（游戏名）"),
    ("vehicle", "载具"),
    ("component / part / block", "部件 / 零件 / 方块"),
    ("microcontroller", "微控制器（Lua 逻辑模块）"),
    ("logic node", "逻辑节点"),
    ("composite", "复合信号"),
    ("on/off signal", "开关信号（布尔）"),
    ("number", "数值信号"),
    ("bool", "布尔值"),
    ("workbench", "工作台"),
    ("subassembly", "子装配体"),
    ("grid / selection grid", "栅格 / 选择栅格"),
    ("modular engine", "模块化引擎"),
    ("cylinder", "气缸"),
    ("crankshaft", "曲轴"),
    ("camshaft", "凸轮轴"),
    ("cooling / coolant", "冷却 / 冷却液"),
    ("radiator", "散热器"),
    ("intercooler", "中冷器"),
    ("turbocharger / turbo", "涡轮增压器"),
    ("supercharger", "机械增压器"),
    ("fuel / fuel tank", "燃料 / 燃料箱"),
    ("air intake / exhaust", "进气 / 排气"),
    ("manifold", "歧管"),
    ("engine", "引擎 / 发动机"),
    ("motor", "马达 / 电机"),
    ("generator", "发电机"),
    ("battery", "电池"),
    ("solar panel", "太阳能板"),
    ("propeller", "螺旋桨"),
    ("rotor", "旋翼 / 转子"),
    ("jet engine", "喷气引擎"),
    ("thruster / RCS", "推进器 / 反作用控制系统"),
    ("rudder", "方向舵"),
    ("aileron", "副翼"),
    ("elevator", "升降舵"),
    ("control fin", "控制鳍"),
    ("wing", "机翼"),
    ("tail", "尾翼"),
    ("landing gear", "起落架"),
    ("wheel / tyre", "车轮 / 轮胎"),
    ("suspension", "悬挂"),
    ("buoyancy", "浮力"),
    ("keel", "龙骨"),
    ("hull", "船体"),
    ("fluid / liquid / gas", "流体 / 液体 / 气体"),
    ("pump", "泵"),
    ("valve", "阀门"),
    ("relief valve", "泄压阀 / 安全阀"),
    ("flow rate", "流量"),
    ("pressure", "压力"),
    ("temperature", "温度"),
    ("heat exchanger", "热交换器"),
    ("desalinator", "海水淡化器"),
    ("distillation", "蒸馏"),
    ("electrolyser", "电解器"),
    ("separator", "分离器"),
    ("radar", "雷达"),
    ("sonar", "声呐"),
    ("GPS", "全球定位系统"),
    ("transponder", "应答器"),
    ("radio / receiver / transmitter", "无线电 / 接收机 / 发射机"),
    ("camera / monitor", "摄像头 / 显示器"),
    ("sensor", "传感器"),
    ("gyro / gyroscope", "陀螺仪"),
    ("altimeter", "高度表"),
    ("compass", "罗盘"),
    ("seat", "座椅"),
    ("winch / rope", "绞盘 / 绳索"),
    ("connector", "连接器"),
    ("pivot / robotic pivot", "枢轴 / 机械转轴"),
    ("linear actuator", "线性作动器"),
    ("multibody", "多体（物理联动）"),
    ("warhead", "弹头"),
    ("ammo / ammunition", "弹药"),
    ("autocannon", "机炮"),
    ("torpedo", "鱼雷"),
    ("missile", "导弹"),
    ("inventory", "货舱 / 库存"),
    ("crate / container", "货箱 / 集装箱"),
    ("mission", "任务"),
    ("objective", "目标"),
    ("survivor / rescue", "幸存者 / 救援"),
    ("creative mode", "创造模式"),
    ("custom game mode", "自定义游戏模式"),
    ("rogue mode / ironman", "铁人模式"),
    ("dedicated server", "专属服务器"),
    ("Steam Workshop", "Steam 创意工坊"),
    ("addon", "附加内容 / 模组"),
    ("DLC", "可下载内容"),
    ("HUD", "平视显示器（抬头显示）"),
    ("FPS / tick rate", "帧率 / 逻辑刷新率"),
    ("despawn", "消失（超出视野后卸载）"),
    ("physics glitch / wobble", "物理抖动 / 鬼畜"),
]

CJK = re.compile(r"[\u4e00-\u9fff]")


# ------------------------------------------------------------------ 解析

def read_tsv(path):
    """读取汉化 TSV，返回 (rows, warnings)。rows 为 4 元组列表。"""
    raw = open(path, "rb").read()
    txt = raw.decode("utf-8-sig", errors="replace")
    rows, warnings = [], []
    for lineno, r in enumerate(csv.reader(io.StringIO(txt), delimiter="\t"), start=1):
        if lineno == 1 and r and r[0].strip().lower() == "id":
            continue
        if not r:
            continue
        if len(r) != 4:
            r = (r + ["", "", "", ""])[:4]
            warnings.append("第 %d 行列数异常，已按 4 列补齐/截断" % lineno)
        rows.append([c.strip() for c in r])
    return rows, warnings


def classify(row):
    """给单行打上 kind / family / module / topic 标记。"""
    _id, _desc, en, zh = row
    if _id.startswith("def_"):
        parts = _id.split("_")
        family = parts[1] if len(parts) > 1 else ""
        suffix = parts[-1]
        if _id.endswith("_s_desc"):
            kind = "s_desc"                      # 一句话简介
        elif suffix == "name":
            kind = "name"                        # 部件名
        elif suffix == "label":
            kind = "label"                       # 逻辑节点 / 属性标签
        elif "_node_" in _id and suffix == "desc":
            kind = "node_desc"                   # 逻辑节点说明
        elif suffix == "desc":
            kind = "desc"                        # 详细说明
        else:
            kind = "other"
        if family in FAMILY_MAP:
            module, family_cn = FAMILY_MAP[family]
        elif family.isdigit():          # def_01_block / def_16_invpyramid ... 基础方块族
            module, family_cn = "结构建材", "基础方块"
        else:
            module, family_cn = "其他部件", family or "其他"
        return dict(kind=kind, family=family, family_cn=family_cn,
                    module=module, topic="")
    kind = "ui"
    topic = "通用界面"
    for name, pat in UI_RULES:
        if re.search(pat, en):
            topic = name
            break
    return dict(kind=kind, family="", family_cn="", module="界面文案", topic=topic)


def is_untranslated(en, zh):
    if not en:
        return False
    if not zh:
        return True
    if zh == en:
        # 形如 Atan2 / HUD / SSAO 这类术语保留原文，不算漏翻
        return bool(re.search(r"\s", en)) or bool(CJK.search(en))
    return False


def build(src_path):
    rows, warnings = read_tsv(src_path)
    entries = []
    for row in rows:
        _id, _desc, en, zh = row
        if not en and not zh and not _id:
            continue  # 空行
        info = classify(row)
        entries.append(OrderedDict([
            ("id", _id),
            ("kind", info["kind"]),
            ("module", info["module"]),
            ("family", info["family"]),
            ("family_cn", info["family_cn"]),
            ("topic", info["topic"]),
            ("en", en),
            ("zh", zh),
            ("state", "todo" if is_untranslated(en, zh) else "ok"),
        ]))
    return entries, warnings


# ------------------------------------------------------------------ 写出

def _w(path, text, newline="\n"):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline=newline) as f:
        f.write(text)


def write_snapshot(entries, path):
    """紧凑快照，只保留比对所需的三元组（id / en / zh）。"""
    lines = []
    for e in entries:
        if not e["en"]:            # 空英文行不参与增量比对
            continue
        lines.append(json.dumps({"i": e["id"], "e": e["en"], "z": e["zh"]},
                                ensure_ascii=False, separators=(",", ":")))
    _w(path, "\n".join(lines) + "\n")


def _md_escape(s):
    return s.replace("|", "\\|").replace("\n", "<br>")


def write_jsonl(entries, path):
    _w(path, "\n".join(json.dumps(e, ensure_ascii=False) for e in entries) + "\n")


def write_tsv(entries, path):
    buf = io.StringIO()
    w = csv.writer(buf, delimiter="\t", lineterminator="\n")
    w.writerow(["id", "分类模块", "族", "类型", "英文", "中文", "状态"])
    for e in entries:
        w.writerow([e["id"], e["module"], e["family_cn"] or e["topic"],
                    e["kind"], e["en"], e["zh"], e["state"]])
    _w(path, buf.getvalue())


def write_core_dict(entries, path):
    d, conflicts = OrderedDict(), []
    for e in entries:
        en = e["en"]
        if not en:
            continue
        if en in d:
            if d[en] != e["zh"] and e["zh"]:
                conflicts.append((en, d[en], e["zh"]))
            continue
        d[en] = e["zh"]
    payload = OrderedDict([
        ("_meta", {"generated": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                   "count": len(d), "note": "EN -> ZH 去重快查字典，键为英文原文，值为汉化文本"}),
        ("dict", d),
        ("conflicts", conflicts[:200]),
    ])
    _w(path, json.dumps(payload, ensure_ascii=False, indent=1))


def write_part_dicts(entries, out_dir):
    """按模块拆分的部件词典 Markdown。"""
    by_module = defaultdict(lambda: defaultdict(list))
    for e in entries:
        if e["kind"] == "ui":
            continue
        by_module[e["module"]][e["family_cn"]].append(e)
    dic = os.path.join(out_dir, "词典")
    for fn in os.listdir(dic) if os.path.isdir(dic) else []:
        if fn.startswith("部件_") and fn.endswith(".md"):
            os.remove(os.path.join(dic, fn))       # 清掉上一轮的旧分类文件
    files = []
    for module in MODULE_ORDER:
        fams = by_module.get(module)
        if not fams:
            continue
        lines = ["# 部件中英对照 · %s" % module, ""]
        lines.append("> 数据来自 Stormworks 创意工坊简体中文汉化补丁（`language.tsv`）。")
        lines.append("> 类型列：`name`=部件名，`desc`=详细说明，`s_desc`=一句话简介，"
                     "`label`=逻辑节点/属性名，`node_desc`=逻辑节点说明。")
        lines.append("")
        total = sum(len(v) for v in fams.values())
        lines.append("本模块共 **%d** 条，%d 个族。" % (total, len(fams)))
        lines.append("")
        for fam in sorted(fams, key=lambda f: -len(fams[f])):
            items = fams[fam]
            lines.append("## %s（%d）" % (fam, len(items)))
            lines.append("")
            lines.append("| id | 类型 | 英文 | 中文 |")
            lines.append("| --- | --- | --- | --- |")
            for e in items:
                zh = e["zh"] or "（未翻译）"
                lines.append("| `%s` | %s | %s | %s |" % (
                    e["id"], e["kind"], _md_escape(e["en"]), _md_escape(zh)))
            lines.append("")
        p = os.path.join(dic, "部件_%s.md" % module)
        _w(p, "\n".join(lines))
        files.append((module, total, p))
    return files


def write_ui_dict(entries, out_dir):
    ui = [e for e in entries if e["kind"] == "ui" and e["en"]]
    by_topic = defaultdict(list)
    for e in ui:
        by_topic[e["topic"]].append(e)
    lines = ["# 界面文案与提示中英对照", ""]
    lines.append("> 这些条目在汉化补丁中没有 `id`（游戏内 UI、提示、剧情、地名、生物名等）。")
    lines.append("> 主题分组由关键词规则自动判定，仅供检索导航，不代表官方分类。")
    lines.append("")
    lines.append("共 **%d** 条。按主题分组如下：" % len(ui))
    lines.append("")
    for t in UI_TOPIC_ORDER:
        if t in by_topic:
            lines.append("- %s（%d）" % (t, len(by_topic[t])))
    lines.append("")
    for t in UI_TOPIC_ORDER:
        items = by_topic.get(t)
        if not items:
            continue
        lines.append("## %s（%d）" % (t, len(items)))
        lines.append("")
        lines.append("| 英文 | 中文 |")
        lines.append("| --- | --- |")
        for e in items:
            zh = e["zh"] or "（未翻译）"
            lines.append("| %s | %s |" % (_md_escape(e["en"]), _md_escape(zh)))
        lines.append("")
    p = os.path.join(out_dir, "词典", "界面与文案.md")
    _w(p, "\n".join(lines))
    return len(ui), p


def write_quick_ref(entries, out_dir, stats):
    names = [e for e in entries if e["kind"] == "name" and e["en"]]
    lines = ["# Stormworks 常用术语速查", ""]
    lines.append("> 本文件是**精简版**，可整体读入上下文。完整数据见 `词典/` 与 `数据/sw_glossary.jsonl`。")
    lines.append("")
    lines.append("## 一、核心概念与常见词")
    lines.append("")
    lines.append("| English | 中文 |")
    lines.append("| --- | --- |")
    for en, zh in CORE_CONCEPTS:
        lines.append("| %s | %s |" % (en, zh))
    lines.append("")
    lines.append("## 二、部件名称速查（%d 条）" % len(names))
    lines.append("")
    lines.append("| English | 中文 | 分类 |")
    lines.append("| --- | --- | --- |")
    for e in sorted(names, key=lambda x: (x["module"], x["en"].lower())):
        zh = e["zh"] or "（未翻译）"
        lines.append("| %s | %s | %s |" % (
            _md_escape(e["en"]), _md_escape(zh), e["module"]))
    lines.append("")
    p = os.path.join(out_dir, "常用术语速查.md")
    _w(p, "\n".join(lines))
    return len(names), p


def write_todo(entries, out_dir):
    todo = [e for e in entries if e["state"] == "todo"]
    lines = ["# 待补翻清单（%d 条）" % len(todo), ""]
    lines.append("> 判定规则：中文为空，或中文与英文完全相同（术语缩写如 HUD/SSAO 不计入）。")
    lines.append("> 翻译后请到 <https://github.com/BKN46/stormworks-translate-chn> 提交 PR。")
    lines.append("")
    for e in todo:
        lines.append("- [%s] %s" % (e["module"], e["en"]))
    _w(os.path.join(out_dir, "数据", "待补翻清单.txt"), "\n".join(lines) + "\n")
    return len(todo)


def write_readme(out_dir, stats, src_path, part_files, generated):
    mod_rows = "\n".join("| %s | %d | [`词典/部件_%s.md`](词典/部件_%s.md) |" %
                         (m, n, m, m) for m, n, _ in part_files)
    text = """# Stormworks 中英对照表

由创意工坊简体中文汉化补丁（[BKN46/stormworks-translate-chn]({gh})）自动生成，
供**人和 AI** 在做 Stormworks 内容的中英互译时作为**唯一术语基准**。

- 生成时间：{generated}
- 数据源：`<SW_LANG_TSV>` = `<SW_WORKSHOP>\\<工坊物品ID>\\language.tsv`
  （**盘符与工坊物品 ID 都不固定**，由 `脚本/sw_locate.py` 按文件名搜索解析。
  本次实际读取：`{src}`；当前机器的解析结果见 `工作区导航\路径配置.json`）
- 条目总数：**{total}**（部件 {parts} + 界面文案 {ui}）
- 去重后英文词条：{uniq} ；待补翻：{todo}

## 给 AI 的使用规则（重要）

0. **查表前先跑一遍新鲜度检查**（毫秒级，不会拖慢）：
   ```bash
   python 脚本/sw_check.py --auto
   ```
   上次更新超过 **7 天**，或创意工坊 `language.tsv` 内容发生变化时，它会自动重建对照表；
   否则什么也不做直接退出。状态码：`0`=最新，`2`=需要更新但未执行，`3`=失败。
1. 涉及 Stormworks 游戏内容（部件名、UI 文案、任务/剧情、Lua 与微控制器术语、地名生物名等）的**中译英或英译中**，
   一律**先查本目录的对照表**，采用其中的既有译法，不要自行意译。
2. 查表优先级：
   - 精确查：`数据/sw_core_dict.json`（EN→ZH 去重字典）
   - 关键字查：`python 脚本/sw_lookup.py "关键词"`（支持中英文、id、分类）
   - 整类浏览：`词典/部件_<模块>.md`、`词典/界面与文案.md`
   - 常用词很快就能在 `常用术语速查.md` 里找到，可整体读入上下文
3. 表中没有的词，才允许自行翻译，并应**沿用同族既有译法的用词习惯**（如 propeller→螺旋桨、rotor→旋翼/转子）。
4. 条目中 `###` 是游戏内的数值占位符；`[$[action_xxx]]` 是按键提示占位符，翻译时保留原样。
5. 汉化补丁本身存在少量错误，若发现明显误译，以游戏内实际功能为准，并在更新日志中记录。

## 自动更新机制（不依赖任何 AI 工具）

| 环节 | 说明 |
| --- | --- |
| **数据源** | 以创意工坊 `language.tsv` 为主（Steam 自动同步，最贴近游戏本体）；GitHub 上游仅在主数据源缺失时兜底 |
| **触发方式一** | Windows 定时任务 `StormworksGlossarySync`，**每天 10:00** 运行 `sw_check.py --auto`，开机错过会自动补跑 |
| **触发方式二** | AI 或用户手动执行 `python 脚本/sw_check.py --auto` |
| **是否重建** | 仅当「距上次更新 > 7 天」或「主数据源 SHA-256 变了」才重建，否则秒退，不产生日志噪音 |
| **时间节点** | 记录在 `数据/last_update.json`（`last_update` / `last_check` / 源文件 mtime·大小·哈希 / 条目统计） |

相关命令：

```bash
# 查看状态 / 需要则更新
python 脚本/sw_check.py                  # 只报告
python 脚本/sw_check.py --auto           # 过期就自动重建
python 脚本/sw_check.py --json           # 机器可读
python 脚本/sw_check.py --days 3         # 临时改用 3 天阈值
python 脚本/sw_check.py --force          # 无条件重建

# 手动完整同步（默认不联网，只用工坊文件）
python 脚本/update_glossary.py
python 脚本/update_glossary.py --use-github   # 额外抓 GitHub 做条目数对照
```

管理定时任务（PowerShell，需管理员身份可改其他用户）：

```powershell
Get-ScheduledTask StormworksGlossarySync      # 查看
Start-ScheduledTask StormworksGlossarySync    # 立即跑一次
Disable-ScheduledTask StormworksGlossarySync  # 暂停
Unregister-ScheduledTask StormworksGlossarySync -Confirm:$false   # 删除
```

> 任务以 S4U 方式注册（不保存密码、注销后也能运行）。因为不需要联网，功能不受影响。

## 目录结构

```
汉化相关/
├─ README_中英对照表.md      本文件（入口 + AI 规则）
├─ 常用术语速查.md           精简版，可整体读入
├─ 更新日志.md               每次同步的变更记录
├─ 词典/
│  ├─ 界面与文案.md          UI / 提示 / 剧情 / 地名 / 生物名
{modlist}
├─ 数据/
│  ├─ sw_glossary.jsonl      全量条目（每行一条 JSON，机器可读）
│  ├─ sw_glossary.tsv        全量条目（Excel / 人工校对）
│  ├─ sw_core_dict.json      EN→ZH 去重快查字典
│  ├─ last_update.json       更新时间节点与源文件指纹（新鲜度判定依据）
│  └─ 待补翻清单.txt
└─ 脚本/
   ├─ build_glossary.py      解析汉化补丁并生成全部文件
   ├─ update_glossary.py     以工坊文件为主源，比对 → 重建 → 写日志与状态
   ├─ sw_state.py            更新状态 / 源文件指纹 / 过期判定
   ├─ sw_check.py            新鲜度检查（过期则 --auto 重建）
   └─ sw_lookup.py           查询工具（过期会在 stderr 提示）
```

## 查询示例

```bash
python 脚本/sw_lookup.py "modular engine cylinder"   # 英文模糊查
python 脚本/sw_lookup.py --zh 螺旋桨                  # 中文反查
python 脚本/sw_lookup.py --id def_giga_prop_small_name
python 脚本/sw_lookup.py --cat 引擎与动力 --limit 40
```

## 数据字段说明（sw_glossary.jsonl）

| 字段 | 含义 |
| --- | --- |
| `id` | 汉化补丁中的标识，形如 `def_<族>_..._name`；UI 文案为空 |
| `kind` | `name` 部件名 / `desc` 详细说明 / `s_desc` 一句话简介 / `label` 逻辑节点·属性名 / `node_desc` 逻辑节点说明 / `ui` 界面文案 |
| `module` | 16 个模块之一，或 `界面文案` |
| `family` / `family_cn` | 部件族（英文 id 片段 / 中文名） |
| `topic` | UI 文案的主题分组 |
| `en` / `zh` | 英文原文 / 简体中文译文 |
| `state` | `ok` 已译 / `todo` 待补翻 |
""".format(
        gh="https://github.com/BKN46/stormworks-translate-chn",
        generated=generated,
        src=src_path,
        total=stats["total"], parts=stats["parts"], ui=stats["ui"],
        uniq=stats["uniq"], todo=stats["todo"],
        modlist="\n".join("│  ├─ 部件_%s.md（%d 条）" % (m, n) for m, n, _ in part_files) or "│  （无）",
    )
    _w(os.path.join(out_dir, "README_中英对照表.md"), text)
    return mod_rows


# ------------------------------------------------------------------ 主流程

def main(argv):
    src = argv[1] if len(argv) > 1 else DEFAULT_SRC
    out = argv[2] if len(argv) > 2 else DEFAULT_OUT
    if not os.path.exists(src):
        print("找不到源文件：%s" % src)
        return 2

    generated = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    entries, warnings = build(src)

    parts = sum(1 for e in entries if e["kind"] != "ui")
    ui = len(entries) - parts
    uniq = len({e["en"] for e in entries if e["en"]})
    todo = sum(1 for e in entries if e["state"] == "todo")
    stats = dict(total=len(entries), parts=parts, ui=ui, uniq=uniq, todo=todo)

    os.makedirs(os.path.join(out, "数据"), exist_ok=True)
    os.makedirs(os.path.join(out, "词典"), exist_ok=True)
    os.makedirs(os.path.join(out, "脚本"), exist_ok=True)

    write_jsonl(entries, os.path.join(out, "数据", "sw_glossary.jsonl"))
    write_snapshot(entries, os.path.join(out, "数据", "_snapshot.jsonl"))
    write_tsv(entries, os.path.join(out, "数据", "sw_glossary.tsv"))
    write_core_dict(entries, os.path.join(out, "数据", "sw_core_dict.json"))
    write_todo(entries, out)
    part_files = write_part_dicts(entries, out)
    write_ui_dict(entries, out)
    write_quick_ref(entries, out, stats)
    write_readme(out, stats, src, part_files, generated)

    print("源：%s" % src)
    print("输出：%s" % out)
    print("条目 %d（部件 %d / 界面 %d），去重英文 %d，待补翻 %d" %
          (len(entries), parts, ui, uniq, todo))
    for m, n, _ in part_files:
        print("  模块 %-10s %5d 条" % (m, n))
    for w in warnings[:5]:
        print("  警告：%s" % w)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
