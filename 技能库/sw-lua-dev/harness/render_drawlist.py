#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""render_drawlist.py — 把 sw_sim.js 报告里的绘制指令渲染成 PNG（近似渲染，供目检）。

依赖：PIL（用 <PYN> 解释器跑：numpy/PIL）。
用法：
  python render_drawlist.py report.json [--outdir out_png] [--tick N] [--scale 4]

渲染语义（近似游戏端）：
  黑底；drawClear 用当前色填充；drawRect 负宽高按镜像处理（工坊脚本有此惯用法）；
  drawText 用 PIL 默认位图字体（游戏端字型不同，只做构图核对，不是像素级真相）。

输出：<outdir>/tick<N>_mon<k>.png；退出码 0=有图；1=报告无绘制帧。
"""

import argparse
import json
import sys
from pathlib import Path

from PIL import Image, ImageDraw

try:
    sys.stdout.reconfigure(encoding="utf-8")
except Exception:
    pass


def norm_rect(x, y, w, h):
    x2, y2 = x + w, y + h
    if x2 < x:
        x, x2 = x2, x
    if y2 < y:
        y, y2 = y2, y
    return x, y, x2, y2


def render_frame(frame, outdir, scale):
    outs = []
    for k, mon in enumerate(frame["monitors"], 1):
        w, h = int(mon["w"] * scale), int(mon["h"] * scale)
        img = Image.new("RGB", (w, h), (0, 0, 0))
        dr = ImageDraw.Draw(img)
        lw = max(1, scale)
        for op in mon["ops"]:
            c = tuple(int(v) for v in (op.get("color") or [255, 255, 255, 255])[:3])
            a = [v if isinstance(v, (int, float)) else 0 for v in op["args"]]
            S = lambda v: v * scale
            fn = op["fn"]
            if fn == "drawClear":
                dr.rectangle([0, 0, w, h], fill=c)
            elif fn == "drawLine" and len(a) >= 4:
                dr.line([S(a[0]), S(a[1]), S(a[2]), S(a[3])], fill=c, width=lw)
            elif fn == "drawRect" and len(a) >= 4:
                dr.rectangle(norm_rect(S(a[0]), S(a[1]), S(a[2]), S(a[3])), outline=c, width=lw)
            elif fn == "drawRectF" and len(a) >= 4:
                dr.rectangle(norm_rect(S(a[0]), S(a[1]), S(a[2]), S(a[3])), fill=c)
            elif fn == "drawCircle" and len(a) >= 3:
                r = abs(a[2])
                dr.ellipse([S(a[0] - r), S(a[1] - r), S(a[0] + r), S(a[1] + r)], outline=c, width=lw)
            elif fn == "drawCircleF" and len(a) >= 3:
                r = abs(a[2])
                dr.ellipse([S(a[0] - r), S(a[1] - r), S(a[0] + r), S(a[1] + r)], fill=c)
            elif fn == "drawTriangle" and len(a) >= 6:
                pts = [(S(a[0]), S(a[1])), (S(a[2]), S(a[3])), (S(a[4]), S(a[5]))]
                dr.polygon(pts, outline=c)
            elif fn == "drawTriangleF" and len(a) >= 6:
                pts = [(S(a[0]), S(a[1])), (S(a[2]), S(a[3])), (S(a[4]), S(a[5]))]
                dr.polygon(pts, fill=c)
            elif fn == "drawText" and len(a) >= 3:
                dr.text((S(a[0]), S(a[1])), str(op["args"][2]), fill=c)
            elif fn == "drawTextBox" and len(a) >= 5:
                x0, y0 = S(a[0]), S(a[1])
                text = str(op["args"][4])
                # 简易装箱：按像素宽换行裁剪
                maxw = S(a[2]) if a[2] else mon["w"] * scale - x0
                line, lines = "", []
                for word in text.split(" "):
                    trial = (line + " " + word).strip()
                    if dr.textlength(trial) > maxw and line:
                        lines.append(line)
                        line = word
                    else:
                        line = trial
                lines.append(line)
                for i, ln in enumerate(lines[: max(1, int(a[3] // 6))]):
                    dr.text((x0, y0 + i * 11 * scale // 2), ln, fill=c)
            else:
                print("  (跳过未知指令 %s)" % fn)
        outp = outdir / ("tick%d_mon%d.png" % (frame["tick"], k))
        img.save(outp)
        outs.append(outp)
    return outs


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("report")
    ap.add_argument("--outdir", default="sw_sim_png")
    ap.add_argument("--tick", type=int, help="选某一 tick 的帧（默认最后一帧）")
    ap.add_argument("--scale", type=int, default=4)
    args = ap.parse_args()

    rep = json.loads(Path(args.report).read_text(encoding="utf-8"))
    frames = rep.get("draw_frames") or []
    if not frames:
        print("报告里没有绘制帧（脚本可能没有 onDraw，或 --draw-ticks 没记录）")
        sys.exit(1)
    frame = frames[-1]
    if args.tick:
        for f in frames:
            if f["tick"] == args.tick:
                frame = f
                break
        else:
            print("没有 tick=%d 的帧；可用：" % args.tick, [f["tick"] for f in frames])
            sys.exit(1)
    outdir = Path(args.outdir)
    outdir.mkdir(parents=True, exist_ok=True)
    for p in render_frame(frame, outdir, args.scale):
        print("✔ %s" % p)


if __name__ == "__main__":
    main()
