# 设置与配置

Avalonia 版设置页按左侧选项卡组织。改完多数会自动保存；也可点 **「保存设置」** / **「打开 JSON」** / **「恢复默认设置」**。

路径与字段以源码为准：`SVL.Avalonia/Views/SettingsPageView.axaml`、`Models/AppUserSettings.cs`、`Services/AppUserSettingsStore.cs`。

## 目录

- [打开设置](#打开设置)
- [选项卡一览](#选项卡一览)
- [基本设置](#基本设置)
- [下载设置](#下载设置)
- [个性化](#个性化)
- [其他](#其他)
- [关于](#关于)
- [匿名活跃统计](#匿名活跃统计)
- [配置文件](#配置文件)
- [与旧版差异](#与旧版差异)

## 打开设置

![设置 · 基本设置（Linux · v1.2.0.0）](../tutorials/image/avalonia/settings.png)

侧栏小标题「参数与行为配置中心」。选项卡：**基本设置** / **下载设置** / **个性化** / **其他** / **关于**。顶栏显示 `settings.json` 路径（Linux 例 `/home/…/.local/share/SVL/Avalonia/settings.json`）；按钮 **保存设置** / **打开 JSON** / **恢复默认设置**。


1. 左侧导航点 **「设置」**（本地化键 `Nav.Settings`）。
2. 页顶会显示当前 `settings.json` 路径。

> 快捷键 `Ctrl + ,`：Avalonia 版 **未见** 等价 KeyGesture 绑定；请用左侧导航 **「设置」**。

## 选项卡一览

| 选项卡 | 本地化键 | 主要内容 |
|--------|----------|----------|
| **基本设置** | `Settings.Tab.Basic` | 窗口标题、启动器标题/简称、启动后行为、联机相关 |
| **下载设置** | `Settings.Tab.Download` | 缓存/代理、并发、Nexus、NXM、缓存清理、检测并发 |
| **个性化** | `Settings.Tab.Personalization` | 主题、强调色、动画、透明度、字号、语言 |
| **其他** | `Settings.Tab.Other` | 通知、调试、托盘 |
| **关于** | `Settings.Tab.About` | 作者、版本、更新通道 |

## 基本设置

| 界面文案 | 说明 |
|----------|------|
| **游戏窗口标题** | 可含占位符；旁有「?」帮助；实机默认 `<default>` |
| **启动器标题** | 窗口标题栏；实机默认 `Stardew Valley Launcher` |
| **启动器简称** | 应用简称；实机默认 `SVL` |
| **游戏启动后启动器行为** | 下拉五项（`LauncherVisibility` 0–4）：游戏启动后立即关闭；隐藏，游戏退出后自动关闭；隐藏，游戏退出后重新打开；**最小化**（默认）；仍保持不变 |
| **启动时自动连接服务器** | 勾选框 |
| **服务器地址** | 例 `127.0.0.1:24642` |
| **Steam 大厅 ID（64 位数字）** | 水印例 `109775241234567890`；提示「自动连接支持 64 位 Steam 大厅数字 ID；游戏内邀请码和 IP 地址仍须手动加入。」（实机 OCR；版本设置页另有相近 axaml 文案） |

实例级启动选项另见版本设置 → **「设置」**，写入 `instance-launch-settings.json`。

## 下载设置

| 界面文案 | 说明 |
|----------|------|
| **启用下载缓存** | 复用已下文件 |
| **启用下载代理** | HTTP 代理；可填地址与可选用户名/密码 |
| **启用任务浮动按钮** | 下载任务浮钮 |
| **Collection 冲突策略** | 整合包/Collection 冲突处理 |
| **下载任务并发上限** | `CollectionDownloadParallelism`（默认 **3**，约 1–10；含 Collection/整合包） |
| **下载线程数** | `DownloadSegmentThreads`（默认 **4**；分片线程） |
| **接管下载** | 说明「粘贴 http/https 下载地址，另存为本地文件。适用于非 Nexus/CurseForge 来源的 Mod 或资源。」；水印 `https://example.com/mod.zip`；按钮 **另存为并下载**（另存对话框标题「接管下载 - 另存为」） |
| **NexusMods 账户** | 登录 / 验证状态 / 刷新 Token / 退出；可看配额 |
| **Nexus 登录失效提醒** | 可关 |
| **NXM 协议** | **启动时尝试注册 NXM 协议**；按钮 **重新注册 NXM 协议**（平台能力因 OS 而异；无首启强制弹窗） |
| **社区汉化数据源** | GitHub / Gitee |
| **缓存管理** | 分类清理、保留时长、打开缓存目录 |
| **检测并发** | UI：**Mod 更新检测线程数** / **Mod 汉化检测线程数**（`MaxConcurrentModUpdateChecks` / `MaxConcurrentModLocalizationChecks`，默认各 **4**） |
| **默认 SMAPI / Mod 源** | 仅 `settings.json` 字段 `DefaultSmapiSource`（默认 GitHub）、`DefaultModSource`（默认 NexusMods）；**设置页 UI 无对应控件**（迁移/目录逻辑会读） |


### 缓存管理（下载设置内）

界面文案（`SettingsPageView.axaml`）：

| 分类 | 清理按钮效果（状态栏） |
|------|------------------------|
| **社区汉化** | 「社区汉化缓存已清理」 |
| **SMAPI 下载** | 清 SMAPI 安装包缓存 |
| **下载安装** | 清安装过程缓存 |
| **图片/图标** | 清图片缓存 |
| **下载文件缓存** | 清通用下载缓存 |
| **游戏本体下载缓存** | 清游戏本体下载缓存 |
| **Nexus 下载缓存** | 清 Nexus 相关下载缓存 |

另有：**总缓存大小** / **缓存文件数**、**搜索/汉化缓存保留时长（分钟）**、**下载归档缓存保留时长（分钟）**（提示「至少 1 小时」）、**刷新统计** / **清理过期** / **打开缓存目录** / **全部清理**。  
**社区汉化数据源** 下拉为 `Gitee` / `GitHub`（提示：GitHub 国际源，Gitee 国内加速；首选失败自动备用）。

## 个性化

![设置 · 个性化（Linux · v1.2.0.0）](../tutorials/image/avalonia/theme.png)


| 界面文案 | 说明 |
|----------|------|
| **主题模式** | 浅色 / 深色 / 跟随系统 |
| **配色方案** | 星露谷（默认）、天空蓝、森林绿、薰衣紫、海洋青、樱花粉、夕阳橙 |
| **自定义强调色** | `#RGB` / `#RRGGBB`，可「应用」「恢复默认」 |
| **启用动画** | 开/关 |
| **主窗口透明效果强度** | 0–100 滑条（默认 25%） |
| **界面字体大小** | `12 / 13 / 14 / 15 / 16 / 18 / 20`（默认 14） |
| **界面语言** | `zh-CN` / `en-US` |

## 其他

| 界面文案（本地化键） | 说明 |
|----------|------|
| **显示通知** | `Settings.Other.ShowNotifications` |
| **来源为全部时提示类型筛选不可用** | `Settings.Other.TypeFilterNotice` |
| **启用调试模式** | 需**重启启动器**后生效 |
| **启动时最小化到托盘** | |
| **关闭窗口时最小化到托盘** | |

## 关于

- 作者卡片：**盛夏de背影** / `mc_shengxia`；按钮 **赞助支持**
- 启动器信息：版本号与技术栈展示（**.NET 10 + Avalonia 11（跨平台）**）
- 按钮：**查看源码** / **打开官网**

### 更新设置（关于页卡片）

副标题文案：「自动检查和版本通道策略」。勾选与下拉（`LocalizationService` 中文键）：

| UI | 字段 / 选项 |
|----|-------------|
| **启动时自动检查更新** | `EnableAutoUpdateCheck`（默认开） |
| **发现新版本时自动下载** | `AutoDownloadUpdate`（依赖上一开关） |
| **发现新版本时显示提示** | `ShowUpdateNotification`（默认开；依赖自动检查） |
| **更新源偏好** | `PreferredUpdateSource`：`GitHub (推荐)` / `Gitee (国内加速)` |
| **更新通道** | `UpdateChannel`：`稳定版` / `预览版`（预览版会查 prerelease） |
| 状态行 | 更新状态 / 最新版本 / 更新源 / **当前包体**（运行时模式） |
| **立即检查更新** | `CheckLauncherUpdateCommand` |

页内提示：「关闭更新提示后仍会在后台下载，安装需手动确认。」自动下载**不会**自动安装并重启；需用户确认安装。

## 匿名活跃统计

启动时 `App.axaml.cs` 会 fire-and-forget 调用 `AnonymousUsageTelemetryService.ReportDailyActiveAsync()`：

- 端点：`https://api.svl.qzz.io/api/stats/usage/report`
- 内容：匿名 ID（安装 GUID 的 SHA-256）、启动器版本、`net10.0`、`OSVersion`、UTC 时间戳；**不**采用户名 / 游戏路径等
- 频率：UTC 日最多一次；状态文件 `LocalApplicationData/SVL/telemetry/usage-state.json`（兼容旧 WPF PascalCase）
- **关闭方式**：环境变量 `SVL_DISABLE_ANON_TELEMETRY=1`（或 `true`）。设置页**无**对应开关

来源：`AnonymousUsageTelemetryService.cs`。

## 配置文件

主配置是 **JSON**，不是 YAML / LiteDB。

### 位置（Avalonia）

`Environment.SpecialFolder.LocalApplicationData` + `SVL/Avalonia/`：

| 平台 | 目录示例 |
|------|----------|
| Windows | `%LocalAppData%\SVL\Avalonia\` |
| Linux | `~/.local/share/SVL/Avalonia/` |
| macOS | `~/Library/Application Support/SVL/Avalonia/` |

| 文件 | 用途 |
|------|------|
| **settings.json** | 全局用户设置（`AppUserSettings`） |
| **instances-registry.json** | 手动登记的实例路径 |
| **instance-launch-settings.json** | 按实例路径覆盖的启动选项 |

设置页可点 **「打开 JSON」** 直接打开 `settings.json`。

### settings.json 字段（节选）

以 `AppUserSettings` 为准，例如：

- `UiLanguage`、`ThemeMode`、`ThemeStyleName`、`PrimaryColor`
- `EnableDownloadCache`、`EnableDownloadProxy`、`DownloadProxyUrl`
- `CollectionDownloadParallelism`、`DownloadSegmentThreads`
- `DefaultSmapiSource`、`DefaultModSource`（无设置页控件）
- `NexusOAuthAccessToken` / Refresh / 用户信息（敏感，勿分享）
- `RegisterNxmProtocolOnStartup`、`EnableAutoUpdateCheck`、`AutoDownloadUpdate`、`ShowUpdateNotification`、`UpdateChannel`、`PreferredUpdateSource`
- `DebugMode`、`MinimizeToTrayOnClose`、`BackgroundTransparencyPercent`
- `PreferredLaunchMode`（默认「自动」）、`EnableSafeLaunch`（启动页只读展示；安装 SMAPI 等会改写）

完整字段见源码，勿手改未知键。

### 旧版残留（非主路径）

| 旧内容 | 说明 |
|--------|------|
| WPF `instances.json`（程序目录旁等） | 首次启动可由迁移服务读入 |
| `YamlConfigProvider` / `*.yaml` | Core 仍有通用实现；**Avalonia 用户设置不以 yaml 为主** |
| LiteDB | Avalonia / Core.Platform **未引用**；设置不以 LiteDB 存储 |

## 与旧版差异

| 旧 Wiki / WPF 表述 | Avalonia 现状 |
|--------------------|---------------|
| `%LocalAppData%\SVL\config.yaml` | **`…\SVL\Avalonia\settings.json`** |
| 强调色等写在 yaml 示例里 | JSON 字段 + 设置页 |
| 「开机自启动」等 | 设置页 **无** 开机自启项；仅有托盘相关（启动/关闭最小化到托盘） |
| 实例 `enableIsolation` 开关 | **1.1.8.2 起版本设置页已移除隔离开关**；见 [版本隔离](./Version-Isolation) |

---

## 相关文档

- [主题与外观](./Theming)
- [下载管理器](./Download-Manager)
- [NexusMods 集成](./NexusMods-Integration)
- [版本隔离](./Version-Isolation)
