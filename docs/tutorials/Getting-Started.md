# 初次使用

第一次打开 Avalonia 版 SVL：添加 Base，再用 SMAPI 建第一个 **versions** 隔离实例。

> 先按 [安装指南](./Installation) 装好 Win / Linux / macOS 包。  
> 配置在 `LocalApplicationData/SVL/Avalonia/`（见安装指南）。  
> 按钮文案以本机界面为准。

![启动页空状态（Linux · v1.2.0.0）](image/avalonia/main.png)

顶栏导航（从左到右）：**启动**、**下载**、**任务**、**设置**。
无实例时左侧可见 **启动游戏**（禁用）、**版本选择**、**版本设置**（禁用）；主区为「欢迎使用星露谷物语启动器 / 尚未配置游戏实例」引导。

## 目录

- [概念](#概念)
- [添加 Base](#添加-base)
- [用 SMAPI 建实例](#用-smapi-建实例)
- [拖放 SMAPI / 整合包](#拖放-smapi--整合包)
- [确认成功](#确认成功)
- [下一步](#下一步)

## 概念

| 名词 | 含义 |
|------|------|
| **Base** | Steam / GOG 等装好的游戏目录 |
| **隔离实例** | `Base/versions/<名>/`，独立 Mods / 常独立 SMAPI |
| **存档** | **共享**系统默认存档目录（见 [版本隔离](../features/Version-Isolation)） |

没有「启用隔离」开关：装 SMAPI / 整合包时默认写入 `versions`。

## 添加 Base

1. 启动后若已探测到安装目录，可直接用。  
2. 没有则点 **「版本选择」**。  
3. 路径操作里点 **「添加」**，选游戏根目录（可粘贴路径）。  
4. 左栏出现路径，右栏 **Base** 分组可见卡片。

![版本选择 · 路径列表空状态（Linux · v1.2.0.0）](image/avalonia/instances.png)

多平台探测逻辑见启动器 `GameInstallPathLocator`（路径因 Steam/GOG 而异）。

## 用 SMAPI 建实例

| 来源 | 登录 | 备注 |
|------|------|------|
| GitHub | 通常不需要 | 常见默认源 |
| CurseForge | 需要 | 需已登录 |
| NexusMods | 需要 | 受限下载依赖账号；非 Premium 常需浏览器 **Slow Download** 再回传（见 [NexusMods 集成](../features/NexusMods-Integration)） |

步骤：

1. 导航 **「下载」** → 类别 **SMAPI**。  
2. 打开详情 → **安装**。  
3. 选 **Base**，输入实例名。  
4. 在 **「任务」** 看进度。  
5. 回到版本选择：**Versions** 下应出现新卡片（带 SMAPI 标签）。

![下载 · SMAPI 类别（Linux · v1.2.0.0）](image/avalonia/downloads.png)

下载侧栏类别：**游戏本体**（SteamCMD 登录下载）、**SMAPI**、**Mod**、**Modpack**；下方为进行中/历史任务摘要。

也可在 **版本设置 → 自动安装 → 安装 / 更改 SMAPI** 对已有路径操作。详见 [创建游戏实例](./Creating-Instance)、[SMAPI 管理](../features/SMAPI-Management)。

## 拖放 SMAPI / 整合包

把官方 SMAPI zip 或整合包拖进窗口，按提示选 Base / 起名。版本选择页也有 **「导入整合包」**。

## 确认成功

- 版本选择里能看到新 **Versions** 实例。  
- 启动页选中该实例后点 **「启动游戏」**。  
- 需要装 Mod：启动页 **「Mod管理」** 或版本设置 → **Mod 管理**（见 [安装 Mods](./Installing-Mods)）。

Nexus 自动下载前： **设置 → 下载设置 → NexusMods 账户** 登录。

![下载 · Mod 搜索（Linux · v1.2.0.0）](image/avalonia/mods.png)

![设置 · 基本设置（Linux · v1.2.0.0）](image/avalonia/settings.png)

## 下一步

- [创建游戏实例](./Creating-Instance)
- [安装 Mods](./Installing-Mods)
- [Modpack 整合包](../features/Modpack-Support)
- [设置与配置](../features/Settings)
