#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Stormworks 武器弹道参考实现（离线验证 / 查表工具）

数值来源：Fandom Wiki《Search and Destroy DLC》(pageid 1264, rev 4717, V1.15.12 / 2026-03-19)
中文名来源：D:\\STORMWORKS\\汉化相关\\（创意工坊简体中文汉化补丁）

模型（wiki 原文）：
  重力    —— 弹丸 30 m/s²（载具是 10 m/s²，两者不同，别混用）
  阻力    —— 逐 tick 计算：v_new = v_old × (1 - k)，k 为该武器阻力系数
  游戏速率 —— 60 tick/s（由射速与「每发 tick 数」互证：900rpm=4tick、1800rpm=2tick）

用法：
  python ballistics.py table              输出全武器射程对照表（标称 vs 模型计算）
  python ballistics.py drop   <武器>      输出该武器平射弹道降表
  python ballistics.py solve  <武器> <水平距离> [高度差]   解算所需仰角与飞行时间
  python ballistics.py flight <武器> <仰角>                给定仰角，输出落点与飞行时间
  python ballistics.py diag   <武器>      反推与标称射程自洽的阻力系数 / 存活 tick（查错用）

武器名可用中文或英文片段（不区分大小写），例如：机枪 / machine / battle / 贝莎
"""

import math
import sys

# ---------------------------------------------------------------- 常量

TPS = 60                 # tick per second
G_PROJECTILE = 30.0      # m/s²，弹丸重力（V1.3.6 起）
G_VEHICLE = 10.0         # m/s²，载具重力（仅作对照，弹道勿用）
BLOCK = 0.25             # m，1 格 = 0.25 m

# ---------------------------------------------------------------- 武器数据
# 字段：v0 初速 m/s | k 阻力系数(每 tick) | life 弹丸存活 tick | range_wiki wiki 标称射程 m
#       mass 质量(游戏单位) | cost 价格 $ | 备注
WEAPONS = {
    "机枪": dict(en="Machine Gun", v0=800.0, k=0.005, life=120, range_wiki=500.0,
                 mass=10, cost=50, kind="机枪",
                 note="手装 100 发弹链；最大连发 3.33 s 后需手动装填"),
    "轻型自动火炮": dict(en="Light Autocannon", v0=1000.0, k=0.02, life=150, range_wiki=750.0,
                    mass=25, cost=100, kind="自动火炮",
                    note="单管；连发 14.6 s 后过热，冷却 6.266 s"),
    "转管自动火炮": dict(en="Rotary Autocannon", v0=1000.0, k=0.01, life=300, range_wiki=1500.0,
                    mass=400, cost=100, kind="自动火炮",
                    note="6 管；需约 0.5 s 起转；连发 5.56 s 后冷却 6.733 s"),
    "重型自动火炮": dict(en="Heavy Autocannon", v0=900.0, k=0.005, life=600, range_wiki=2500.0,
                    mass=50, cost=100, kind="自动火炮",
                    note="单管高伤；连发 30 s 后冷却 6.266 s；有引信定时器"),
    "坦克主炮": dict(en="Battle Cannon", v0=800.0, k=0.002, life=1500, range_wiki=4500.0,
                 mass=100, cost=100, kind="重炮",
                 note="5 种弹；可手装；开闩77/供弹26/关闩77 tick；有引信定时器"),
    "大型榴弹炮": dict(en="Artillery Cannon", v0=700.0, k=0.001, life=2400, range_wiki=6500.0,
                  mass=200, cost=100, kind="重炮",
                  note="3 种弹；可手装；开闩130/供弹60/关闩280 tick；有引信定时器"),
    "贝莎巨炮": dict(en="Bertha Cannon", v0=600.0, k=0.0005, life=2400, range_wiki=7500.0,
                 mass=500, cost=100, kind="重炮",
                 note="仅 HE / 破片；只能机械装填；开闩305/供弹240/关闩600 tick"),
    "火箭弹发射器": dict(en="Rocket Launcher", v0=1000.0, k=None, life=None, range_wiki=2500.0,
                   mass=50, cost=100, kind="火箭",
                   note="4 联装，打完不可再装填；无后坐力；1 发/秒"),
}

# ---------------------------------------------------------------- 模型


def simulate(v0, k, life, angle_deg, dt_ticks=1, y0=0.0,
             g=G_PROJECTILE, tps=TPS):
    """逐 tick 积分弹道。

    每 tick 顺序：阻力 → 重力 → 位移。返回 (落点水平距离 m, 飞行时间 s, 是否命中存活上限)。
    k=0 表示无阻力（火箭弹发射器 wiki 未给阻力系数）。
    """
    k = 0.0 if k is None else k
    life = 10 ** 9 if life is None else life
    a = math.radians(angle_deg)
    vx, vy = v0 * math.cos(a), v0 * math.sin(a)
    x = y = 0.0
    for t in range(1, life + 1):
        vx *= (1 - k)
        vy *= (1 - k)
        vy -= g / tps
        x += vx / tps
        y += vy / tps
        if y <= y0 and vy < 0:
            return x, t / tps, False
    return x, life / tps, True


def solve_angle(v0, k, life, target_x, target_dy=0.0,
                g=G_PROJECTILE, tps=TPS):
    """给定水平距离与高度差，二分求发射仰角（低伸弹道解）。

    返回 (仰角°, 飞行时间 s)；无解返回 (None, None)。
    低伸解优先——直射武器通常用这一支。
    """
    best = None
    lo, hi = 0.0, 89.0
    for _ in range(60):
        mid = (lo + hi) / 2
        x, t, _ = simulate(v0, k, life, mid)
        if x < target_x:
            lo = mid
        else:
            hi = mid
    ang = (lo + hi) / 2
    x, t, capped = simulate(v0, k, life, ang)
    if abs(x - target_x) > max(1.0, target_x * 0.01):
        return None, None
    return ang, t


def range_drag_limit(v0, k, tps=TPS):
    """阻力极限射程（无限时间、忽略重力）：等比数列求和 v0/(tps·k)。"""
    return float("inf") if not k else v0 / (tps * k)


def range_life_limit(v0, k, life, tps=TPS):
    """存活 tick 内的水平射程（忽略重力），闭式解。"""
    if not k:
        return v0 * life / tps
    return (v0 / tps) * (1 - (1 - k) ** life) / k


# ---------------------------------------------------------------- 输出


def find_weapon(name):
    if name in WEAPONS:
        return name
    low = name.lower()
    for zh, w in WEAPONS.items():
        if low in zh or low in w["en"].lower():
            return zh
    return None


def cmd_table():
    print("Stormworks 武器射程对照（模型计算 vs wiki 标称）")
    print("模型：逐 tick 阻力 v×(1-k)，弹丸重力 30 m/s²，60 tick/s\n")
    hdr = (f"{'武器':<8}{'初速':>7}{'阻力k':>8}{'存活tick':>9}{'阻力极限':>10}"
           f"{'存活极限':>10}{'wiki标称':>9}{'模型射程':>10}{'偏差':>8}")
    print(hdr)
    print("-" * len(hdr) * 2)
    for zh, w in WEAPONS.items():
        if w["k"] is None:
            print(f"{zh:<8}{w['v0']:>7.0f}{'—':>8}{'—':>9}{'—':>10}{'—':>10}"
                  f"{w['range_wiki']:>9.0f}   wiki 未给阻力/存活，无法建模")
            continue
        rd = range_drag_limit(w["v0"], w["k"])
        rl = min(range_life_limit(w["v0"], w["k"], w["life"]), rd)
        # 带重力、扫仰角求最远射程 —— 这才是能直接对标 wiki 标称值的量
        best_x, best_a = 0.0, 0.0
        for a10 in range(1, 900):
            a = a10 / 10
            x, _, _ = simulate(w["v0"], w["k"], w["life"], a)
            if x > best_x:
                best_x, best_a = x, a
        dev = best_x / w["range_wiki"]
        flag = "  ⚠ 偏差大" if not (0.85 <= dev <= 1.25) else ""
        print(f"{zh:<8}{w['v0']:>7.0f}{w['k']:>8.4f}{w['life']:>9}"
              f"{rd:>10.0f}{rl:>10.0f}{w['range_wiki']:>9.0f}{best_x:>10.0f}{dev:>7.2f}x{flag}")
        print(f"{'':8}最优仰角 {best_a:.1f}°")


def cmd_diag(name):
    """诊断：反推与 wiki 标称射程自洽的阻力系数 / 存活 tick。"""
    zh = find_weapon(name)
    if not zh:
        print(f"未找到武器：{name}")
        return
    w = WEAPONS[zh]
    target = w["range_wiki"]
    print(f"{zh} ({w['en']})  wiki 标称射程 {target:.0f} m\n")

    def best_range(v0, k, life):
        bx = 0.0
        for a10 in range(1, 900):
            x, _, _ = simulate(v0, k, life, a10 / 10)
            bx = max(bx, x)
        return bx

    print("① 固定存活 tick，反推阻力系数 k：")
    for k in [0.0005, 0.001, 0.002, 0.005, 0.01, 0.015, 0.02, 0.025, 0.03, 0.04, 0.05]:
        r = best_range(w["v0"], k, w["life"])
        mark = "  ← 接近标称" if abs(r - target) / target < 0.06 else ""
        print(f"   k={k:<7} 射程 {r:>8.0f} m{mark}")

    print("\n② 固定阻力系数，反推存活 tick：")
    for life in [40, 60, 80, 100, 120, 150, 200, 300]:
        r = best_range(w["v0"], w["k"], life)
        mark = "  ← 接近标称" if abs(r - target) / target < 0.06 else ""
        print(f"   life={life:<5} 射程 {r:>8.0f} m{mark}")


def cmd_drop(name):
    zh = find_weapon(name)
    if not zh:
        print(f"未找到武器：{name}")
        return
    w = WEAPONS[zh]
    k = w["k"] or 0.0
    life = w["life"] or 10 ** 9
    print(f"{zh} ({w['en']})  初速 {w['v0']} m/s  阻力 k={w['k']}")
    print("0° 平射降表（阻力同样衰减垂直分量，故下坠小于自由落体 ½gt²）")
    print(f"{'距离m':>8}{'飞行s':>8}{'下坠m':>9}{'下坠格':>8}{'存速':>9}")
    print("-" * 44)
    # 按同一模型积分 0° 弹道，逐 tick 记录，再按 100 m 取样
    vx, vy = w["v0"], 0.0
    x = y = 0.0
    samples = []
    for tick in range(1, life + 1):
        vx *= (1 - k)
        vy *= (1 - k)
        vy -= G_PROJECTILE / TPS
        x += vx / TPS
        y += vy / TPS
        samples.append((x, y, tick / TPS, math.hypot(vx, vy)))
    next_d = 100
    for sx, sy, st, sv in samples:
        if sx >= next_d:
            print(f"{next_d:>8}{st:>8.2f}{-sy:>9.1f}{-sy / BLOCK:>8.1f}{sv:>9.0f}")
            next_d += 100
            if next_d > 20000:
                break


def cmd_solve(name, target_x, dy=0.0):
    zh = find_weapon(name)
    if not zh:
        print(f"未找到武器：{name}")
        return
    w = WEAPONS[zh]
    ang, t = solve_angle(w["v0"], w["k"], w["life"], target_x, dy)
    print(f"{zh} ({w['en']})  目标：水平 {target_x:.0f} m，高差 {dy:+.0f} m")
    if ang is None:
        print("  ✘ 超出该武器射程，无解")
        return
    print(f"  → 仰角 {ang:.2f}°   飞行时间 {t:.2f} s   引信定时设为 {t:.2f}")
    print(f"  → 瞄准点抬高量 ≈ {target_x * math.tan(math.radians(ang)):.1f} m")


def cmd_flight(name, angle):
    zh = find_weapon(name)
    if not zh:
        print(f"未找到武器：{name}")
        return
    w = WEAPONS[zh]
    x, t, capped = simulate(w["v0"], w["k"], w["life"], angle)
    print(f"{zh} ({w['en']})  仰角 {angle:.2f}°")
    print(f"  → 落点 {x:.1f} m   飞行 {t:.2f} s" + ("   ⚠ 触顶（弹丸存活上限）" if capped else ""))


def main():
    args = sys.argv[1:]
    if not args or args[0] in ("-h", "--help"):
        print(__doc__)
        return
    cmd = args[0]
    if cmd == "table":
        cmd_table()
    elif cmd == "drop":
        cmd_drop(args[1])
    elif cmd == "solve":
        cmd_solve(args[1], float(args[2]), float(args[3]) if len(args) > 3 else 0.0)
    elif cmd == "flight":
        cmd_flight(args[1], float(args[2]))
    elif cmd == "diag":
        cmd_diag(args[1])
    else:
        print(__doc__)


if __name__ == "__main__":
    main()
