# NexusMods 集成

在启动器内登录 Nexus、搜索/下载 Mod，并用 **NXM** 协议承接浏览器回调。

源码：`SettingsPageView.axaml`（下载设置）、`DownloadPageView` / Mod 搜索相关页、`OpenNexusLoginCommand`。

![设置入口示意 · 基本设置（Linux · v1.2.0.0）](../tutorials/image/avalonia/settings.png)

> Nexus 登录在同页左侧切到 **「下载设置」** 卡片（本批截图停在基本设置）。

## 目录

- [登录](#登录)
- [下载页登录失效条幅](#下载页登录失效条幅)
- [登录后能做什么](#登录后能做什么)
- [搜索与下载](#搜索与下载)
- [NXM 协议](#nxm-协议)
- [API 额度](#api-额度)
- [Collection](#collection)
- [免费 vs Premium（已核源码语义）](#免费-vs-premium已核源码语义)

## 登录

入口在 **「设置」→「下载设置」→「NexusMods 账户」**（不是旧文独立顶栏「设置 → NexusMods」）。

1. 打开上述卡片。  
2. 点登录按钮：正常为 **登录 Nexus**；凭证失效但有本地档案时为 **重新登录 Nexus**（`NexusLoginActionText`）。  
3. 在浏览器完成 OAuth。  
4. 回到启动器；可点 **「验证状态」** / **「刷新 Token」**。  
5. 退出用 **「退出登录」**。

未登录时：非 Nexus 资源仍可用；NXM / 受限 Nexus 下载会受限。卡片上有对应提示。

### 下载页登录失效条幅

Mod 搜索等处可能出现：「Nexus OAuth 登录已失效，请在设置页重新登录。」

| 按钮 | 行为 |
|------|------|
| **去登录** | 隐藏条幅并跳转设置页（`GoToNexusLogin`） |
| **本次使用期间不提示** | 仅本会话抑制（`_suppressNexusAuthNotificationThisSession`）；退出/重新登录后可恢复 |
| **不再提示** | 写入 `settings.json` 的 `SuppressNexusAuthNotification=true` 并隐藏 |

设置页勾选 **「Nexus 登录失效提醒」** 对应 `EnableNexusAuthNotification`（与 `SuppressNexusAuthNotification` 取反保存；ToolTip：「关闭后下载页将不再提示 Nexus 登录失效」）。

## 登录后能做什么

| 能力 | 说明 |
|------|------|
| 头像 / 用户名 / 会员类型 | 登录态展示 |
| 每日 / 每小时请求 | API 统计 |
| NXM 导入与受限下载 | 需有效登录 |
| 导出补全 FileID | 导出整合包时可尝试补 Nexus/CF FileID |

## 搜索与下载

1. 导航 **「下载」**。  
2. 类别选 **Mod**（或进 Mod 搜索页）。  
3. 搜索 → 详情 → 选文件 → 安装到目标实例。  
4. 进度看导航 **「任务」**。

下载页还可粘贴 `nxm://…`（见下）。

![下载页（Linux · v1.2.0.0）](../tutorials/image/avalonia/downloads.png)

![下载 · Mod（含 Nexus 登录失效提示）（Linux · v1.2.0.0）](../tutorials/image/avalonia/mods.png)

## NXM 协议

设置 → 下载设置 → **「NXM 协议」** 卡片：

| 项 | 作用 |
|----|------|
| **启动时尝试注册 NXM 协议** | 开机/启动时注册 |
| **重新注册 NXM 协议** | 手动再注册 |
| 说明 | 浏览器 `nxm://` 回传到启动器下载流 |

下载页另有 **NXM 链接导入**（水印形如 `nxm://stardewvalley/mods/.../files/...`）与 **导入 NXM**。

平台实现（`SVL.Core.Platform`）：

- **Linux**：freedesktop desktop entry `svl-avalonia-nxm.desktop` + `mimeapps.list`（含桌面环境专用 mimeapps）。
- **macOS**：要求 `.app` 的 `Info.plist` 已声明 nxm URL scheme；缺失则注册失败并提示重新打包。
- 便携解压 / Flatpak 等非标准布局：**可能**注册失败，请用设置内「重新注册」看结果文案。

## API 额度

登录后卡片显示每日 / 每小时请求计数。额度用尽会导致搜索或下载失败；可稍后再试或减少并发（下载设置里的检测/下载并发）。

## Collection

Nexus Collection 可通过整合包安装链路处理（见 [Modpack 整合包](./Modpack-Support)）。完整「一键订阅 Collection」UI 文案以现版下载/导入入口为准，勿照搬旧 WPF 菜单名。

## 免费 vs Premium（已核源码语义）

- 登录态展示会员类型：`Premium` / `Free`（`NexusAuthService` 读 `is_premium`）。
- **非 Premium**：部分 NXM / 自动直链会走 **浏览器下载回退**（`BrowserDownloadFallbackService`）；界面会提示在文件页点 **『Slow Download』**，完成后再回启动器；状态可见「浏览器下载回退：请在浏览器中点击 Manual Download」/「等待浏览器下载（非 Premium）」等（`BrowserDownloadFallbackService`）。
- **Premium**：更易走直接 API/NXM 自动流（仍受 Nexus 配额与登录态约束）。

Flatpak / 纯便携包的 NXM 注册仍依赖上述桌面入口是否写得到，失败时以设置页状态文案为准。

---

## 相关文档

- [设置与配置](./Settings)
- [安装 Mods](../tutorials/Installing-Mods)
- [下载管理器](./Download-Manager)
