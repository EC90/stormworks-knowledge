# -*- coding: utf-8 -*-
"""把 SW示波器 v0.1.3 导出的 CSV 整理成模块化引擎实测记录文档。

用法（示例）：
  python make_record.py --csv "D:/.../1X1 data.csv" --out "D:/.../实测_01_xxx.md" \
      --round 01 --config "1x1曲轴_1x1单缸" --stall 3.0 --cols 1,2,3,4

CSV 假定为 SW示波器 v0.1.3 格式：每行 1 tick（60 tick/s），9 列
  空列, num1, num2, num3, num4, bool1..4
--cols 1,2,3,4 表示取 num1..num4，依次为：制动输入 / RPS / 进气压力 / 柴油流量。
"""
import argparse
import csv

TICK = 60.0  # Stormworks tick/s


def load_rows(path, cols):
    rows = []
    need = max(cols) + 1
    with open(path, newline="") as f:
        for r in csv.reader(f):
            if len(r) > max(cols):
                rows.append(tuple(float(r[c]) for c in cols))
    return rows


def mean(seq):
    return sum(seq) / len(seq) if seq else 0.0


def find_load_start(rows, scan_i=0):
    if scan_i is None:
        return len(rows)  # 无扫描变量（如纯起动/储能测试）→ 全程视为空转段
    for t, r in enumerate(rows):
        if r[scan_i] > 0:
            return t
    return len(rows)


def find_stall(rows, load_start, rps_i, stall):
    """首次跌破 stall 且此后不再回升的位置。"""
    for t in range(load_start, len(rows)):
        if rows[t][rps_i] < stall and max(x[rps_i] for x in rows[t:]) < stall:
            return t
    return None


def pct_time(rows, steady, rps_i, ratios=(0.5, 0.8, 0.9, 0.95, 0.99)):
    out = []
    for p in ratios:
        target = steady * p
        hit = next((t for t, r in enumerate(rows) if r[rps_i] >= target), None)
        out.append((p, target, hit))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--csv", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--round", default="NN")
    ap.add_argument("--config", default="")
    ap.add_argument("--stall", type=float, default=3.0)
    ap.add_argument("--cols", default="1,2,3,4")
    ap.add_argument("--date", default="")
    # 扫描变量（通道1）的称呼：制动输入 / 离合器输入 等
    ap.add_argument("--ch1label", default="3x3轮 可变制动输入值")
    ap.add_argument("--ch1unit", default="0–1")
    ap.add_argument("--ch1key", default="wheel_variable_brake_input")
    # 可选第 5 通道（如扭矩计扭矩）；留空则不启用
    ap.add_argument("--ch5label", default="")
    ap.add_argument("--ch5unit", default="")
    ap.add_argument("--ch5key", default="")
    # 可选第 6 通道（如扭矩计的 RPS 输出）；留空则不启用
    ap.add_argument("--ch6label", default="")
    ap.add_argument("--ch6unit", default="")
    ap.add_argument("--ch6key", default="")
    # 通道角色映射：与 --cols 一一对应，可用角色 scan/rps/press/flow/torque/aux/skip
    ap.add_argument("--roles", default="scan,rps,press,flow")
    args = ap.parse_args()

    cols = [int(x) for x in args.cols.split(",")]
    rows = load_rows(args.csv, cols)
    n = len(rows)
    roles = [x.strip() for x in args.roles.split(",")]
    def ridx(role):
        return roles.index(role) if role in roles else None
    SCAN, RP, PR, FL = ridx("scan"), ridx("rps"), ridx("press"), ridx("flow")
    TQ, TQ2 = ridx("torque"), ridx("aux")
    if RP is None:
        raise SystemExit("--roles 必须包含一个 rps 角色")

    load_start = find_load_start(rows, SCAN)
    has_load = load_start < n
    # 稳态窗口：先找「启动结束点」（空转段内首次达到峰值 98%），再取其到加载起点的区间，上限 600 tick
    free = rows[:load_start] or rows
    free_max = max(r[RP] for r in free)
    spin_end = next((t for t in range(len(free)) if free[t][RP] >= free_max * 0.98), 0)
    wlen = min(600, max(60, (load_start or n) - spin_end))
    win = rows[max(0, load_start - wlen):load_start] or rows[-wlen:]
    steady_rps = mean([r[RP] for r in win])
    band = (min(r[RP] for r in win), max(r[RP] for r in win))
    steady_press = mean([r[PR] for r in win])
    steady_flow = mean([r[FL] for r in win])

    # 空转启动曲线（每 2 s）
    spin = []
    step = 30 if load_start < 1200 else 120  # 空转段短则加密到 0.5 s
    for t in range(0, load_start, step):
        w = rows[max(0, t - 30):min(load_start, t + 30)]
        spin.append((t / TICK, rows[t][RP], mean([x[PR] for x in w]), mean([x[FL] for x in w])))
    if load_start > 0 and (not spin or spin[-1][0] != (load_start - 1) / TICK):
        t = load_start - 1
        w = rows[max(0, t - 30):t + 1]
        spin.append((t / TICK, rows[t][RP], mean([x[PR] for x in w]), mean([x[FL] for x in w])))

    times = pct_time(rows, steady_rps, RP)
    band_hit = next((t for t, r in enumerate(rows) if band[0] <= r[RP] <= band[1]), None)

    # 加载扫描（每 1 s）
    scan = []
    if has_load:
        for t in range(load_start, n, 60):
            r = rows[t]
            scan.append((t, r[SCAN], r[RP], r[PR], r[FL], r[TQ] if TQ is not None else 0.0, r[TQ2] if TQ2 is not None else 0.0))
        r = rows[n - 1]
        if scan and scan[-1][0] != n - 1:
            scan.append((n - 1, r[SCAN], r[RP], r[PR], r[FL], r[TQ] if TQ is not None else 0.0, r[TQ2] if TQ2 is not None else 0.0))

    stall_t = find_stall(rows, load_start, RP, args.stall) if has_load else None

    ext = []
    for i in range(len(cols)):
        col = [r[i] for r in rows]
        ext.append((min(col), max(col)))

    L = []
    A = L.append
    A("# 模块化引擎实测记录 %s — %s\n" % (args.round, args.config))
    A("> **测试日期**：%s ｜ **轮次**：%s ｜ **记录工具**：SW示波器 v0.1.3（DataRecord 微控 + main.exe 端口监听）" % (args.date or "待填", args.round))
    A("> **原始 CSV**：`%s`（本文档附录已收录整理后的完整数据，可独立使用）" % args.csv)
    A(">")
    A("> ⚠ **熄火判据**：模块化发动机起动器（起动机）**全程开启**，因此 **RPS < %g 记为熄火**——" % args.stall)
    A("> 低于该转速时转速由起动器维持，发动机不自持，数据不计入有效工作区。")
    A(">")
    A("> ⚠ **每轮必采基线**：除加载扫描外，**空转（仅带一个 3x3轮、无制动）启动曲线** 为本系列基线，见 §3.2。")
    A("")
    A("---\n")
    A("## 1. 测试条件\n")
    A("### 1.1 动力单元与传动链\n")
    A("| 环节 | 部件（中文名） | 部件（游戏内英文名） | 参数设定 |")
    A("| --- | --- | --- | --- |")
    A("| 动力核心 | 待填 | Modular Engine Crankshaft ... | ×1 |")
    A("| 做功单元 | 待填 | Modular Engine Cylinder ... | ×1 |")
    A("| 进气 | 模块化发动机气体歧管 | Modular Engine Air Manifold | 节气门恒定 1 |")
    A("| 供油 | 模块化发动机燃油歧管 | Modular Engine Fuel Manifold | 节气门恒定 0.5 |")
    A("| 起动 | 模块化发动机起动器（起动机） | Modular Engine Starter | **全程开启** |")
    A("| 传动 | 离合器 | Clutch | 接合压恒定 1 |")
    A("| 负载 | 3x3轮 | Wheel 3x3 | ×1，经离合器驱动 |")
    A("")
    A("### 1.2 加载方式\n")
    A("- 通过 **通道1 的扫描变量（%s）** 施加负载（人工确认其接线）。" % args.ch1label)
    A("- %s 以**线性斜坡**上升（本轮 0 → %.4f）；加载前先空转至稳态（tick 0–%d，约 %.1f s）。"
      % (args.ch1label, ext[0][1], load_start - 1, (load_start - 1) / TICK))
    A("- **起动器全程开启**：RPS 不会真正归零，按本系列判据 **RPS < %g 记为熄火**。" % args.stall)
    A("")
    A("### 1.3 所用部件权威规格（🎮 `sw_defs.py` 查询结果，待补）\n")
    A("| 部件 | 定义文件 | mass | 价格 $ | 尺寸 | 关键逻辑节点 |")
    A("| --- | --- | --- | --- | --- | --- |")
    A("| 待补 | | | | | |")
    A("")
    A("---\n")
    A("## 2. 数据采集方式\n")
    A("- DataRecord 微控每 tick 采样（**60 tick/s**），每 30 tick 经 `async.httpGet` 上传本机 5588 端口，`main.exe` 落盘。")
    A("- 原始 CSV 行格式（9 列，无表头）：`,(num1),(num2),(num3),(num4),(bool1..4)`。")
    A("")
    A("| CSV 列 | 通道 | 含义 | 单位 |")
    A("| --- | --- | --- | --- |")
    role_label = {
        "scan": (args.ch1label, args.ch1unit),
        "rps": ("曲轴 RPS", "转/秒"),
        "press": ("气缸进气压力 / 进气压力", "atm"),
        "flow": ("柴油流量 / 进油流量", "L/s"),
        "torque": (args.ch5label, args.ch5unit),
        "aux": (args.ch6label, args.ch6unit),
        "skip": ("（未使用）", "—"),
    }
    for k, role in enumerate(roles):
        lab, unit = role_label.get(role, (role, ""))
        A("| %d | num %d | %s | %s |" % (k + 2, k + 1, lab, unit))
    A("")
    A("---\n")
    A("## 3. 数据概览\n")
    A("- 总记录长度：**%d tick ≈ %.1f 秒**。" % (n, n / TICK))
    A("- **阶段 A · 空转（tick 0–%d，约 %.1f s）**：%s 恒 0，启动并自由运转至稳态。" % (load_start - 1, load_start / TICK, args.ch1label))
    if has_load:
        A("- **阶段 B · 加载（tick %d–%d，约 %.1f s）**：%s 线性斜坡 0 → %.4f%s。"
          % (load_start, n - 1, (n - load_start) / TICK, args.ch1label, ext[0][1],
             "；其中 **tick %d 起进入熄火区**" % stall_t if stall_t else ""))
    A("")
    A("### 3.1 空转稳态（取加载前末 %.1f s，tick %d–%d）\n"
      % (wlen / TICK, max(0, load_start - wlen), load_start - 1))
    A("| 通道 | min | max | 平均 |")
    A("| --- | --- | --- | --- |")
    chans = [(args.ch1label, SCAN, "")] if SCAN is not None else []
    chans += [("RPS", RP, ""), ("进气压力 (atm)", PR, ""), ("柴油流量 (L/s)", FL, "")]
    for nm, i, unit in chans:
        c = [r[i] for r in win]
        A("| %s | %.4f | %.4f | **%.4f**%s |" % (nm, min(c), max(c), mean(c),
          "（≈ %.2f L/min）" % (mean(c) * 60) if i == FL else ""))
    if TQ is not None:
        c = [r[TQ] for r in win]
        A("| %s | %.4f | %.4f | **%.4f** |" % (args.ch5label, min(c), max(c), mean(c)))
    if TQ2 is not None:
        c = [r[TQ2] for r in win]
        A("| %s | %.4f | %.4f | **%.4f** |" % (args.ch6label, min(c), max(c), mean(c)))
    A("")
    A("> 该配置的**空转稳定转速约 %.2f RPS**，空转油耗约 %.4f L/s。" % (steady_rps, steady_flow))
    A("")
    A("### 3.2 空转（无制动）启动曲线 —— 本系列基线\n")
    A("压力与流量取 ±30 tick 窗口均值以消除单缸冲程振荡；**0 s 行常含启动异常值，不可信**。\n")
    A("| 时间(s) | RPS | 进气压力均值(atm) | 柴油流量均值(L/s) |")
    A("| --- | --- | --- | --- |")
    for t, rps, p, f in spin:
        A("| %.1f | %.3f | %.4f | %.5f |" % (t, rps, p, f))
    A("")
    A("**上升时间（以稳态 %.2f RPS 为基准）**\n" % steady_rps)
    A("| 达到稳态比例 | 对应 RPS | 用时(s) |")
    A("| --- | --- | --- |")
    for p, target, hit in times:
        A("| %.0f%% | %.2f | %s |" % (p * 100, target, "%.1f" % (hit / TICK) if hit is not None else "未达到"))
    A("| 进入稳态带 %.2f–%.2f | — | %s |" % (band[0], band[1], "%.1f" % (band_hit / TICK) if band_hit is not None else "未达到"))
    A("")
    if has_load:
        A("### 3.3 加载扫描（每秒抽样；压力为单 tick 瞬时值，随冲程振荡）\n")
        if stall_t:
            A("> 表中 tick ≥ %d 的行 RPS 已 < %g，属**熄火区**（转速由起动器维持），不参与特性拟合。\n" % (stall_t, args.stall))
        if TQ2 is not None:
            A("| tick | 时间(s) | %s | RPS | %s | 进气压力(atm) | 柴油流量(L/s) | %s | 每冲程油量(L/行程) |" % (args.ch1label, args.ch6label, args.ch5label))
            A("| --- | --- | --- | --- | --- | --- | --- | --- | --- |")
        elif TQ is not None:
            A("| tick | 时间(s) | %s | RPS | 进气压力(atm) | 柴油流量(L/s) | %s | 每冲程油量(L/行程) |" % (args.ch1label, args.ch5label))
            A("| --- | --- | --- | --- | --- | --- | --- | --- |")
        else:
            A("| tick | 时间(s) | %s | RPS | 进气压力(atm) | 柴油流量(L/s) | 每冲程油量(L/行程) |" % args.ch1label)
            A("| --- | --- | --- | --- | --- | --- | --- |")
        for t, br, rps, p, f, tq, tq2 in scan:
            ps = f / (rps / 2) if rps > 0.1 else 0.0
            if TQ2 is not None:
                A("| %d | %.1f | %.6f | %.3f | %.3f | %.4f | %.5f | %.4f | %.5f |" % (t, t / TICK, br, rps, tq2, p, f, tq, ps))
            elif TQ is not None:
                A("| %d | %.1f | %.6f | %.3f | %.4f | %.5f | %.4f | %.5f |" % (t, t / TICK, br, rps, p, f, tq, ps))
            else:
                A("| %d | %.1f | %.6f | %.3f | %.4f | %.5f | %.5f |" % (t, t / TICK, br, rps, p, f, ps))
        A("")
        if stall_t:
            A("**熄火点（RPS < %g 判据）**\n" % args.stall)
            A("| 项目 | 数值 |")
            A("| --- | --- |")
            A("| 首次跌破 %g RPS | tick **%d**（%.1f s），RPS = %.4f |" % (args.stall, stall_t, stall_t / TICK, rows[stall_t][RP]))
            A("| 该时刻 %s | **%.4f** |" % (args.ch1label, rows[stall_t][SCAN]))
            A("| **有效工作区** | %s **0 – %.4f**（tick %d–%d） |" % (args.ch1label, rows[stall_t - 1][SCAN], load_start, stall_t - 1))
            A("")
    A("### 3.%d 全段通道极值\n" % (4 if has_load else 3))
    A("| 通道 | min | max |")
    A("| --- | --- | --- |")
    echans = [(args.ch1label, SCAN)] if SCAN is not None else []
    echans += [("RPS", RP), ("进气压力 (atm)", PR), ("柴油流量 (L/s)", FL)]
    for nm, i in echans:
        A("| %s | %.4f | %.4f |" % (nm, ext[i][0], ext[i][1]))
    if TQ is not None:
        A("| %s | %.4f | %.4f |" % (args.ch5label, ext[TQ][0], ext[TQ][1]))
    if TQ2 is not None:
        A("| %s | %.4f | %.4f |" % (args.ch6label, ext[TQ2][0], ext[TQ2][1]))
    A("")
    A("---\n")
    A("## 4. 观察记录\n")
    A("1. **启动瞬态流量异常**：（脚本提示）检查前约 60 tick 是否出现数百 L/s 的假读数，若是则标注并剔除。")
    A("2. **进气压力**：本轮稳态均值 %.4f atm，冲程振荡区间见上表；压力**与转速基本无关**。" % steady_press)
    A("3. **转速-负载特性**：（待人工补写：高灵敏区、长尾区、熄火点含义）")
    A("4. **油耗-负载特性**：（待人工补写）")
    A("5. **空转启动特性（§3.2）**：（待人工补写：是否非一阶、t90/t50 比值）")
    A("6. **跨轮对比**：与既有轮次的空载稳态 RPS、熄火点、上升时间节点对比（注意各轮扫描变量可能不同）。")
    A("7. **适用范围提示**：（待人工补写本轮配置与边界）")
    A("")
    A("---\n")
    A("## 5. 附录：完整原始数据（整理版）\n")
    A("- 由原始 CSV 整理：剔除空首列与未使用的 4 个布尔列，补 tick 序号与表头；数值与原始文件完全一致。")
    A("- 每行 = 1 tick（1/60 秒），共 %d 行。\n" % n)
    A("```csv")
    # 表头与数据严格按 --roles 的顺序输出，避免出现 None 索引
    keys = {"scan": args.ch1key, "rps": "rps", "press": "intake_pressure_atm",
            "flow": "diesel_flow_lps", "torque": args.ch5key, "aux": args.ch6key}
    header = ["tick"] + [keys.get(role, "ch%d_%s" % (i + 1, role)) for i, role in enumerate(roles)]
    A(",".join(header))
    for t, r in enumerate(rows):
        A(",".join(["%d" % t] + ["%.6f" % r[i] for i in range(len(roles))]))
    A("```")

    with open(args.out, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(L) + "\n")
    print("written:", args.out)
    print("rows=%d load_start=%d steady_rps=%.4f stall_tick=%s" % (n, load_start, steady_rps, stall_t))


if __name__ == "__main__":
    main()
