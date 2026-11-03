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

未登录时：非 Nexus 资源仍可用；NXM / 受限 Nexus 下载会受限。设置卡片原文：「登录后可直接处理 NXM 链接与受限资源」；未登录引导：「未登录时仅可使用非 Nexus 资源；登录后可直接导入 NXM 并执行受限下载。」

### 下载页登录失效条幅

Mod 搜索等处可能出现：「Nexus OAuth 登录已失效，请在设置页重新登录。」

| 按钮 | 行为 | ToolTip（axaml） |
|------|------|------------------|
| **不再提示** | 写入 `settings.json` 的 `SuppressNexusAuthNotification=true` 并隐藏 | 「持久化隐藏，直到在设置页重新开启」 |
| **本次使用期间不提示** | 仅本会话抑制（`_suppressNexusAuthNotificationThisSession`） | 「仅在本次运行期间隐藏」 |
| **去登录** | 跳转设置页 Nexus 登录区（`GoToNexusLogin`） | 「跳转到设置页 Nexus 登录区」 |

设置页勾选 **「Nexus 登录失效提醒」** 对应 `EnableNexusAuthNotification`（与 `SuppressNexusAuthNotification` 取反保存；ToolTip：「关闭后下载页将不再提示 Nexus 登录失效」）。

## 登录后能做什么

| 能力 | 说明 |
|------|------|
| 头像 / 用户名 / 会员类型 | 登录态展示 |
| 每日 / 每小时请求 | API 统计 |
| NXM 协议回调与受限下载 | 需有效登录（下载页无独立粘贴导入控件） |
| 导出补全 FileID | 导出整合包时可尝试补 Nexus/CF FileID |

## 搜索与下载

1. 导航 **「下载」**。  
2. 类别选 **Mod**（或进 Mod 搜索页）。  
3. 搜索 → 详情 → 选文件 → 安装到目标实例。  
4. 进度看导航 **「任务」**。

浏览器唤起的 `nxm://` 由协议注册回传（见下「NXM 协议」）；下载页**无**粘贴框。

![下载页（Linux · v1.2.0.0）](../tutorials/image/avalonia/downloads.png)

![下载 · Mod（含 Nexus 登录失效提示）（Linux · v1.2.0.0）](../tutorials/image/avalonia/mods.png)

## NXM 协议

设置 → 下载设置 → **「NXM 协议」** 卡片（副文案「处理浏览器中的 nxm:// 协议跳转」；说明键「用于浏览器中的 nxm:// 链接快速回传到启动器下载页。」）：

| 项 | 作用 |
|----|------|
| **启动时尝试注册 NXM 协议** | 开机/启动时注册 |
| **重新注册 NXM 协议** | 手动再注册 |
| 说明 | 浏览器 `nxm://` 回传到启动器下载流 |

浏览器 `nxm://` 回调由协议注册承接（`Program` 解析命令行）。`LocalizationService` / `DownloadPageViewModel` 仍有「NXM 链接导入」「导入 NXM」等文案键，但现行 `DownloadPageView.axaml` **未见**粘贴导入控件；请用协议回调或设置页 NXM 注册，勿写「下载页必有粘贴框」。

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
- **非 Premium**：部分 NXM / 自动直链会走 **浏览器下载回退**（`BrowserDownloadFallbackService`）。等待文案示例：「请在浏览器中点击 Manual Download，启动器将自动接管...」/「…接管文件回调...」。可能弹出 `BrowserDownloadGuideDialog`（默认标题「浏览器下载指引」；默认说明「该资源需要在浏览器完成授权或手动下载。请打开链接并完成下载后返回。」；按钮 **复制链接** / **在浏览器打开**）。文件页需点 **Slow Download** / Manual Download 后回传。
- **Premium**：更易走直接 API/NXM 自动流（仍受 Nexus 配额与登录态约束）。

Flatpak / 纯便携包的 NXM 注册仍依赖上述桌面入口是否写得到，失败时以设置页状态文案为准。

---

## 相关文档

- [设置与配置](./Settings)
- [安装 Mods](../tutorials/Installing-Mods)
- [下载管理器](./Download-Manager)
