# NexusMods 集成

在启动器内登录 Nexus、搜索/下载 Mod，并用 **NXM** 协议承接浏览器回调。

源码：`SettingsPageView.axaml`（下载设置）、`DownloadPageView` / Mod 搜索相关页、`OpenNexusLoginCommand`。

![设置页（Linux · v1.2.0.0）](../tutorials/image/avalonia/svl-settings.png)

## 目录

- [登录](#登录)
- [登录后能做什么](#登录后能做什么)
- [搜索与下载](#搜索与下载)
- [NXM 协议](#nxm-协议)
- [API 额度](#api-额度)
- [Collection](#collection)
- [待核实](#待核实)

## 登录

入口在 **「设置」→「下载设置」→「NexusMods 账户」**（不是旧文独立顶栏「设置 → NexusMods」）。

1. 打开上述卡片。  
2. 点登录按钮（界面文案随状态变化，`NexusLoginActionText`）。  
3. 在浏览器完成 OAuth。  
4. 回到启动器；可点 **「验证状态」** / **「刷新 Token」**。  
5. 退出用 **「退出登录」**。

未登录时：非 Nexus 资源仍可用；NXM / 受限 Nexus 下载会受限。卡片上有对应提示。

可选：**「Nexus 登录失效提醒」**（关闭后下载页少提示失效）。

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

## NXM 协议

设置 → 下载设置 → **「NXM 协议」** 卡片：

| 项 | 作用 |
|----|------|
| **启动时尝试注册 NXM 协议** | 开机/启动时注册 |
| **重新注册 NXM 协议** | 手动再注册 |
| 说明 | 浏览器 `nxm://` 回传到启动器下载流 |

下载页另有 **NXM 链接导入**（水印形如 `nxm://stardewvalley/mods/.../files/...`）与 **导入 NXM**。

Linux/macOS 注册是否与系统桌面集成完全一致：**待核实**（以本机「重新注册」结果为准）。

## API 额度

登录后卡片显示每日 / 每小时请求计数。额度用尽会导致搜索或下载失败；可稍后再试或减少并发（下载设置里的检测/下载并发）。

## Collection

Nexus Collection 可通过整合包安装链路处理（见 [Modpack 整合包](./Modpack-Support)）。完整「一键订阅 Collection」UI 文案以现版下载/导入入口为准，勿照搬旧 WPF 菜单名。

## 待核实

- 免费账号 vs Premium 在自动下载上的产品文案差异  
- 桌面端 NXM 在 Flatpak / 便携包场景的注册路径  

---

## 相关文档

- [设置与配置](./Settings)
- [安装 Mods](../tutorials/Installing-Mods)
- [下载管理器](./Download-Manager)
