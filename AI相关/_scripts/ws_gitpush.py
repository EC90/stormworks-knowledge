#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
本机学习流程收尾：把工作区里「值得入库」的更新推送到 GitHub 仓库。

这是原云端分流架构（ws_sync.py → 资料库 drive）的替代方案：工坊实例学习流程完全在本机执行，
收尾时若工作区有变更，就把变更提交并推送到 origin（默认分支 main）。

行为（best-effort，任何一步失败都打印错误并以非 0 退出，调用方用 `|| true` 吞掉，不阻塞主流程）：
  - 检测是否有变更（git status --porcelain）。无变更 → 直接跳过，exit 0（不提交、不推送）。
  - 有变更 → git add -A → 按顶层区域归类生成中文提交说明 → commit → git push origin <branch>。

用法：
  python ws_gitpush.py                 # 检测 → 提交 → 推送
  python ws_gitpush.py --dry           # 只打印将提交/推送的内容，不碰网络、不写库
  python ws_gitpush.py --branch main   # 显式指定分支（默认 main）
  python ws_gitpush.py --repo <路径>    # 显式指定仓库根（默认用 git rev-parse 探测）

依赖：系统 git 已在 PATH；推送认证由当前环境提供（推荐 gh auth setup-git 配置凭据助手）。
"""
import os
import sys
import subprocess

DEFAULT_BRANCH = "main"
# AI相关\_scripts → <WS>（仓库根）
REPO_ROOT_HINT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


def run(cmd, cwd, capture=True, check=True, timeout=180):
    p = subprocess.run(cmd, cwd=cwd, capture_output=capture,
                       text=True, encoding="utf-8", errors="ignore", timeout=timeout)
    if check and p.returncode != 0:
        raise RuntimeError("命令失败 %s rc=%d: %s"
                           % (" ".join(cmd), p.returncode, (p.stderr or p.stdout or "")[-400:]))
    return p


def git(*args, cwd, check=True, timeout=180):
    return run(["git"] + list(args), cwd=cwd, check=check, timeout=timeout)


def classify(path):
    """把变更文件路径归类到可读区域，用于提交说明的小标题。"""
    p = path.replace("\\", "/")
    low = p.lower()
    if "lua示例" in low or low.startswith("数据库/lua/lua示例"):
        return "Lua示例(例题)"
    if low.startswith("ai相关/_meta") or low.startswith("ai相关\\_meta"):
        return "进度账本/榜单"
    if low.startswith("汉化相关"):
        return "汉化词典"
    if low.startswith("数据库"):
        return "知识库数据"
    if "/" in p or "\\" in p:
        return "其他(%s)" % p.replace("\\", "/").split("/")[0]
    return "根目录"


def build_message(lines):
    """依据变更文件清单，按区域归类生成中文提交说明。"""
    cats = {}
    for st, path in lines:
        cats.setdefault(classify(path), []).append(st)
    summary = ["chore(工坊学习): 自动同步本轮新增 Lua 示例与进度", ""]
    for cat in sorted(cats):
        sts = cats[cat]
        added = sum(1 for s in sts if s in ("A", "??"))
        mod = sum(1 for s in sts if s in ("M", "R", "C"))
        dele = sum(1 for s in sts if s == "D")
        parts = []
        if added:
            parts.append("+%d" % added)
        if mod:
            parts.append("~%d" % mod)
        if dele:
            parts.append("-%d" % dele)
        summary.append("- %s: %s" % (cat, " ".join(parts)))
    return "\n".join(summary)


def detect_lines(cwd):
    """返回 [(status_code, path), ...]，仅取无空格的有效行。"""
    out = git("-c", "core.quotepath=false", "status", "--porcelain", cwd=cwd, check=True).stdout
    lines = []
    for raw in out.splitlines():
        if not raw.strip():
            continue
        code = raw[:2]
        path = raw[3:].strip()
        lines.append((code.strip(), path))
    return lines


def main():
    args = sys.argv[1:]
    dry = "--dry" in args
    branch = DEFAULT_BRANCH
    if "--branch" in args:
        branch = args[args.index("--branch") + 1]
    repo = None
    if "--repo" in args:
        repo = args[args.index("--repo") + 1]

    # 定位仓库根
    if repo and os.path.isdir(repo):
        cwd = os.path.abspath(repo)
    else:
        try:
            cwd = git("rev-parse", "--show-toplevel", cwd=REPO_ROOT_HINT, check=True).stdout.strip()
        except Exception:
            cwd = REPO_ROOT_HINT
    cwd = os.path.abspath(cwd)
    print("[gitpush] 仓库根: %s" % cwd)

    # 确认是 git 仓库
    try:
        git("rev-parse", "--is-inside-work-tree", cwd=cwd, check=True)
    except Exception as e:
        print("[gitpush] 不是 git 仓库，跳过：%s" % e)
        print("[gitpush] RESULT: SKIP 未检测到 git 仓库，未提交未推送")
        sys.exit(0)

    # 检测变更（-c core.quotepath=false 让 git 输出原始 UTF-8 路径，避免中文被八进制转义后无法归类）
    lines = detect_lines(cwd)
    if not lines:
        print("[gitpush] 工作区无变更，跳过（不提交、不推送）。")
        print("[gitpush] RESULT: SKIP 工作区无变更，未提交未推送")
        sys.exit(0)
    print("[gitpush] 检测到 %d 个变更文件：" % len(lines))
    for code, path in lines:
        print("   %-3s %s" % (code, path))

    msg = build_message(lines)
    print("[gitpush] 提交说明：\n%s" % msg)

    if dry:
        print("[gitpush] DRY：未执行 add/commit/push。")
        sys.exit(0)

    # 暂存全部（.gitignore 已排除 _tools/、pony IDE/、.workbuddy/、_work/ 等，不会误入）
    git("add", "-A", cwd=cwd, check=True)
    git("commit", "-m", msg, cwd=cwd, check=True)

    # 推送（默认推到显式分支；未指定时用当前分支）
    cur = git("rev-parse", "--abbrev-ref", "HEAD", cwd=cwd, check=True).stdout.strip()
    push_branch = branch if branch else cur
    print("[gitpush] 推送到 origin/%s ..." % push_branch)
    git("push", "origin", push_branch, cwd=cwd, check=True, timeout=300)
    print("[gitpush] 已提交并推送。")
    print("[gitpush] RESULT: SUCCESS 已提交并推送 origin/%s" % push_branch)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("[gitpush] 失败（best-effort，调用方可忽略）：%s" % e)
        print("[gitpush] RESULT: FAIL %s" % e)
        sys.exit(1)
