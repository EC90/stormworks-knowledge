# SW Lua 读取处理视频信号（by BKN）· 仓库索引

> 外部 MOD 工具的文档副本；**MOD 二进制（DLL）不入库**（2026-09-08 仓库瘦身）。

## 这是什么

BKN（bkn46，另见 `数据库\Lua\_原始资料\BKN的Stormworks Lua手册\`，主页 bkn46.github.io/bknsw）
制作的视频信号读取 MOD：通过替换 `OpenAL64.dll` 注入，把摄像头画面暴露给游戏内 Lua 的
`video` 库，实现单摄像头取像（gray / rgb 模式）。`out/README.md` 是完整的安装与 Lua API 文档。

## 目录内保留

| 路径 | 说明 |
| --- | --- |
| `out/README.md` | 安装/卸载步骤 + `video.init()` 等 Lua API（核心参考价值） |
| `out/examples/*.lua` | 官方示例：灰度/彩色分量、调屏、RGB64 上屏等 5 篇 |
| `out/video_get/*.json` | MOD 配置/hook 计划/运行时上下文/签名（文本，供分析） |

## 未入库（需另行获取）

| 文件 | 大小 | 用途 |
| --- | --- | --- |
| `out/OpenAL64.dll` | ~168 KB | 注入用假 DLL（覆盖游戏根目录同名文件，原版改名 `OpenAL64_real.dll`） |
| `out/video_get/StormworksVideoGet.dll` | ~2 MB | MOD 核心 |

从原作者分发渠道（BKN 主页 / 社区帖子）获取后按 `out/README.md` 安装。
