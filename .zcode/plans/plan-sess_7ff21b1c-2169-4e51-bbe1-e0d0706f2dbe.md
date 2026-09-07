## 在 ZCode 上新增「WorkBuddy 时段开关」两个定时自动化

### 已查明的事实
- 活跃平台主程序：`D:\workbuddy\WorkBuddy.exe`（Electron 应用，主进程与渲染/helper 子进程同名或带 Helper 后缀）。
- 时序衔接：22:50 关 WorkBuddy → 23:00 ZCode 学习窗口开始 → 次日 09:00 学习窗口结束 → 09:30 拉起 WorkBuddy，互不重叠。

### 一、创建自动化 1：每晚关闭 WorkBuddy
- 标题：`每晚22:50关闭WorkBuddy进程`
- cron：`50 22 * * *`，recurring=true
- prompt 要点（自包含）：
  - 用 PowerShell `Get-Process` 枚举进程名为 `WorkBuddy*` 的进程（即 D:\workbuddy\WorkBuddy.exe 及其子进程）；
  - 先优雅关闭（`CloseMainWindow()`），等待约 15 秒；
  - 仍存活的用 `taskkill /F /IM WorkBuddy.exe` 强制结束；
  - 若本就没有 WorkBuddy 进程 → 输出「未发现运行中的 WorkBuddy，跳过」；
  - 只针对 WorkBuddy，不碰 WorkBuddyAI.exe 与其他任何进程；失败只报告不重试。

### 二、创建自动化 2：每天早上启动 WorkBuddy
- 标题：`每天早上9:30启动WorkBuddy`
- cron：`30 9 * * *`，recurring=true
- prompt 要点（自包含）：
  - 先检查 WorkBuddy.exe 是否已在运行，已运行则输出「已在运行，跳过」；
  - 未运行则 `Start-Process 'D:\workbuddy\WorkBuddy.exe'`，等 30 秒后复查进程确认拉起成功并报告。

### 三、验证
- 两个自动化创建后核对 id 与下次触发时间（今晚 22:50 / 明早 9:30）。
- 实际生效由今晚/明早的真实触发验证；如需立即验证可让我手动按 prompt 执行一次关闭+启动。

### 已知注意点（向你说明，不阻塞）
- 若 WorkBuddy 内部的「stormworks工坊实例学习」自动化在 22:00 左右启动了一轮且尚未收尾，22:50 强杀会丢掉该轮未落盘的成果（其账本是整轮收尾才写）——建议仍按此前约定在 WorkBuddy 里暂停该自动化，这样 22:50 关闭就无损。
- 定时触发依赖 ZCode 在对应时刻处于运行状态（与 23:00 学习自动化同一前提）。