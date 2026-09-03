# Stowrmworks Lua 读取视频信号

## 安装

1. 将游戏原有的 `OpenAL64.dll` 改名为 `OpenAL64_real.dll`。
2. 将包内 `OpenAL64.dll` 复制到游戏根目录。
3. 将包内整个 `video_get` 文件夹复制到游戏根目录。

如果游戏更新后不可用的话，重新替换一下dll应该就可以  

## 卸载

1. 将 `OpenAL64_real.dll` 名字改回 `OpenAL64.dll` 替换掉MOD版本


## 使用注意

想要读取视频信号必须将视频信号接到一个屏幕输出  
当前只能够稳定支持单摄像头+Lua读取  

## Lua API

### 初始化

```lua
ok, err = video.init(width, height, mode)
ok, err = video.init(slot, width, height, mode)
```

| 参数 | 说明 |
| --- | --- |
| `slot` | 可选，视频输入编号；省略时为 `1`。 |
| `width` | 请求输出宽度。 |
| `height` | 请求输出高度。 |
| `mode` | `"gray"` 或 `"rgb"`。 |

当前默认配置上限：

| 模式 | 最大尺寸 |
| --- | ---: |
| `gray` | `160x90` |
| `rgb` | `64x64` |

建议优先使用 `64x36` 或更低分辨率。再次调用 `video.init(...)` 可以修改同一 slot 的尺寸或模式。

### 状态和信息

```lua
connected = video.isConnected(slot)
ready = video.isReady(slot)
width, height = video.getSize(slot)
frame_id, width, height, mode = video.getInfo(slot)
```

- `isConnected` 表示 Lua 视频输入是否解析到 Stormworks 视频源。
- `isReady` 表示至少已经完成一帧抓取。
- `getSize` 返回配置的输出尺寸。
- `getInfo` 返回最新帧编号、尺寸和模式。
- 省略 `slot` 时使用 slot 1。

### 矩阵读取

```lua
pixels, err = video.get(slot)
gray, err = video.getGray(slot)
rgb, err = video.getRGB(slot)
```

`video.get(slot)` 根据 `video.init` 选择的模式返回灰度或 RGB 数据。

灰度像素结构：

```lua
local p = gray[y][x]
local px = p[1]
local py = p[2]
local value = p[3]
```

RGB 像素结构：

```lua
local p = rgb[y][x]
local px = p[1]
local py = p[2]
local color = p[3]
local r = color[1]
local g = color[2]
local b = color[3]
```

矩阵接口会创建大量 Lua 表，不建议在较高分辨率下每 tick 调用。

### Packed 读取

```lua
bytes, err = video.getPackedGray(slot)
bytes, err = video.getPackedRGB(slot)
```

replace-DLL 游戏路径返回从索引 1 开始的连续字节数组。灰度数据每像素 1 字节：

```lua
gray = bytes[(y - 1) * width + x]
```

RGB 数据每像素 3 字节，顺序为 `R, G, B`：

```lua
local offset = ((y - 1) * width + (x - 1)) * 3
local r = bytes[offset + 1]
local g = bytes[offset + 2]
local b = bytes[offset + 3]
```

需要持续处理画面时，优先使用 Packed 接口。

## 屏幕回放示例

示例文件：

```text
examples\video_rgb_64_to_screen.lua
```

该脚本请求 `64x64` RGB 画面，在 `onTick` 中读取 Packed RGB，并在 `onDraw` 中按屏幕尺寸缩放绘制。请先确认最小测试状态达到 `3`，再使用屏幕回放示例。

## 日志

日志位于游戏目录：

```text
video_get\logs\openal_proxy.log
video_get\logs\video_get.log
```

本版本会在每次加载时清理上一轮日志，同时删除旧运行时快照、JSONL load event、帧预览和 archive。正常情况下日志很短。

`openal_proxy.log` 应包含：

```text
fresh log start previous logs cleared
bootstrap start attempt=1 ...
bootstrap returned result=1
```

`video_get.log` 应包含：

```text
configured mode=replace_dll ...
hook_runtime installed ... target_patch_points_modified=true installed_count=8 ...
```

运行期非错误诊断默认关闭。抓帧是否成功以 Lua 状态、尺寸和帧编号为准。Hook 失败、panic 和其他错误仍会写入 `video_get.log`。

## 常见问题

### `video == nil` 或状态 `-10`

- 确认同时替换了 `OpenAL64.dll` 和完整的 `video_get` 文件夹。
- 检查 `openal_proxy.log` 是否出现 `bootstrap returned result=1`。
- 检查 `video_get.log` 是否出现 `configured mode=replace_dll`。
- 游戏更新后，当前包可能因哈希或目标字节不匹配而失效。

### 状态一直为 `1`

Lua API 已工作，但视频输入未连接。确认摄像机 `Video Signal` 连接到了运行该脚本的微控制器 `Video Input 1`，然后重新生成或重新载入载具。

### 状态一直为 `2`

输入连接已识别，但没有可用帧。检查同一个摄像机输出是否也连接到了供电并参与渲染的显示器，并先用单摄像机结构排除多路路由问题。

当前摄像机到 Lua 组件的精确路由仍在实验阶段，因此接线正确时状态也可能停留在 `2`。

### 状态为 `3`，但画面不正确或不更新

- 帧编号不变表示没有新帧进入 Lua。
- 帧编号变化但采样和不变，可能是静止画面、黑帧或错误纹理。
- 多摄像机出现串画面时，退回单摄像机测试并记录接线结构。
