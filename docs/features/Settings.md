# 设置与配置

Avalonia 版设置页按左侧选项卡组织。改完多数会自动保存；也可点 **「保存」** / **「打开 JSON」** / **「恢复默认设置」**。

路径与字段以源码为准：`SVL.Avalonia/Views/SettingsPageView.axaml`、`Models/AppUserSettings.cs`、`Services/AppUserSettingsStore.cs`。

## 目录

- [打开设置](#打开设置)
- [选项卡一览](#选项卡一览)
- [基本设置](#基本设置)
- [下载设置](#下载设置)
- [个性化](#个性化)
- [其他](#其他)
- [关于](#关于)
- [配置文件](#配置文件)
- [与旧版差异](#与旧版差异)

## 打开设置

![设置页（Linux · v1.2.0.0）](../tutorials/image/avalonia/settings.png)


1. 左侧导航点 **「设置」**（本地化键 `Nav.Settings`）。
2. 页顶会显示当前 `settings.json` 路径。

> 快捷键 `Ctrl + ,`：**待核实**（Avalonia 版 axaml 未看到等价绑定）。

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
| **游戏窗口标题** | 可含占位符；旁有「?」帮助 |
| **启动器标题** | 窗口标题栏文字 |
| **启动器简称** | 应用简称 |
| **游戏启动后启动器行为** | 关闭 / 隐藏后关闭或恢复 / 最小化 / 保持不变（存为整数 `LauncherVisibility`） |
| **启动时自动连接…** | 与 Steam 大厅相关（具体勾选文案随语言包） |
| **服务器地址 / Steam 邀请码** | 大厅数字 ID 等；字母邀请码与 IP 仍可能需游戏内手动加入 |

实例级启动选项另见版本设置 → **「设置」**，写入 `instance-launch-settings.json`。

## 下载设置

| 界面文案 | 说明 |
|----------|------|
| **启用下载缓存** | 复用已下文件 |
| **启用下载代理** | HTTP 代理；可填地址与可选用户名/密码 |
| **启用任务浮动按钮** | 下载任务浮钮 |
| **Collection 冲突策略** | 整合包/Collection 冲突处理 |
| **下载任务并发上限** | 含 Collection/整合包，约 1–10 |
| **下载线程数** | 分片线程 |
| **接管下载** | 粘贴 http(s) 直链「另存为并下载」 |
| **NexusMods 账户** | 登录 / 验证状态 / 刷新 Token / 退出；可看配额 |
| **Nexus 登录失效提醒** | 可关 |
| **NXM 协议** | 启动时注册、立即注册（平台能力因 OS 而异） |
| **社区汉化数据源** | GitHub / Gitee |
| **缓存管理** | 分类清理、保留时长、打开缓存目录 |
| **检测并发** | Mod 更新检测 / 汉化检测线程数 |

## 个性化

| 界面文案 | 说明 |
|----------|------|
| **主题模式** | 如「跟随系统」等 |
| **配色方案** | 如 Stardew 等样式名 |
| **自定义强调色** | `#RGB` / `#RRGGBB`，可清空 |
| **动画** | 开/关 |
| **背景透明度** | 0–100 滑条 |
| **字体大小** | pt |
| **界面语言** | 如 `zh-CN` |

## 其他

| 界面文案 | 说明 |
|----------|------|
| **显示通知** | |
| **类型筛选不可用提示** | 「全部」来源时是否提示 |
| **调试模式** | 需重启后生效 |
| **启动时最小化到托盘** | |
| **关闭时最小化到托盘** | |

## 关于

- 作者信息、赞助入口
- 版本号与技术栈展示（**.NET 10 + Avalonia 11**）
- **查看源码** / **打开官网**
- 更新：自动检查、自动下载（不自动安装重启）、通知开关、更新源、通道、手动检查

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
- `NexusOAuthAccessToken` / Refresh / 用户信息（敏感，勿分享）
- `RegisterNxmProtocolOnStartup`、`EnableAutoUpdateCheck`、`UpdateChannel`
- `DebugMode`、`MinimizeToTrayOnClose`、`BackgroundTransparencyPercent`

完整字段见源码，勿手改未知键。

### 旧版残留（非主路径）

| 旧内容 | 说明 |
|--------|------|
| WPF `instances.json`（程序目录旁等） | 首次启动可由迁移服务读入 |
| `YamlConfigProvider` / `*.yaml` | Core 仍有通用实现；**Avalonia 用户设置不以 yaml 为主** |
| LiteDB | **待核实**：Avalonia 主路径未见作为设置存储 |

## 与旧版差异

| 旧 Wiki / WPF 表述 | Avalonia 现状 |
|--------------------|---------------|
| `%LocalAppData%\SVL\config.yaml` | **`…\SVL\Avalonia\settings.json`** |
| 强调色等写在 yaml 示例里 | JSON 字段 + 设置页 |
| 「开机自启动」等 | **待核实**：当前设置页未见该项 |
| 实例 `enableIsolation` 开关 | **1.1.8.2 起版本设置页已移除隔离开关**；见 [版本隔离](./Version-Isolation) |

---

## 相关文档

- [主题与外观](./Theming)
- [下载管理器](./Download-Manager)
- [NexusMods 集成](./NexusMods-Integration)
- [版本隔离](./Version-Isolation)
