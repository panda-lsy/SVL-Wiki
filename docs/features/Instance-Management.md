# 游戏实例管理

管理 Base 路径、Versions 隔离实例，以及版本设置各页。

主界面示意（Linux · v1.2.0.0）：

![启动页空状态（Linux · v1.2.0.0）](../tutorials/image/avalonia/main.png)

顶栏导航：**启动**、**下载**、**任务**、**设置**。

## 目录

- [实例是什么](#实例是什么)
- [进入版本选择](#进入版本选择)
- [路径与卡片](#路径与卡片)
- [创建与导入](#创建与导入)
- [版本设置](#版本设置)
- [启动相关](#启动相关)
- [隔离说明](#隔离说明)

## 实例是什么

| 类型 | 含义 |
|------|------|
| **Base** | 原始游戏安装目录 |
| **Version（隔离实例）** | `Base/versions/<名>/`，独立 Mods / 常含独立 SMAPI |

- Mods：**按实例隔离**
- 存档：**共享**系统默认目录（见 [版本隔离](./Version-Isolation)）

## 进入版本选择

启动页按钮：

| 按钮 | 作用 |
|------|------|
| **启动游戏** | 启动当前选中实例 |
| **版本选择** | 打开实例/路径页 |
| **Mod管理** | 有可用实例时显示，进版本设置的 Mod 管理 |
| **版本设置** | 打开当前实例的版本设置 |

也可在实例卡片上点齿轮（工具提示「版本设置」）或星标收藏。

## 路径与卡片

![版本选择 · 路径列表（Linux · v1.2.0.0）](../tutorials/image/avalonia/instances.png)

![添加实例对话框（Linux · v1.2.0.0）](../tutorials/image/avalonia/add-instance.png)

版本选择页（`InstancesPageView`）：

| 区域 | 内容 |
|------|------|
| 左 · 路径列表 | 显示名、版本、游戏路径 |
| 左 · **路径操作** | **添加** / **导入整合包** / **刷新** / **打开文件夹** |
| 右 · **选择启动版本** | 分组 **Base** / **Versions** |

路径右键（已核 axaml）：**重命名**、**打开文件夹**、**刷新信息**、**删除**。删除对话框标题 **「删除路径」**，确认文案含「该操作**不会删除游戏文件**」（`Instances.Dialog.DeletePath`）——仅从启动器列表移除登记，不删磁盘游戏目录。现版**无**「克隆实例」。

实例卡片：名称、原版/SMAPI 标签与版本、路径；齿轮进版本设置，星标收藏。

## 创建与导入

详见 [创建游戏实例](../tutorials/Creating-Instance)。摘要：

1. **添加** Base 文件夹  
2. 下载/拖入 **SMAPI** → 命名 → 生成 Versions 实例  
3. **导入整合包** 或下载页安装整合包  

无「启用隔离」勾选；隔离为默认产物。

## 版本设置

| 侧栏 | 内容摘要 |
|------|----------|
| **概览** | 版本信息；改图标 / 名称 / 描述 / 收藏并保存；快捷方式「版本文件夹」「存档文件夹」（`ApplicationData/StardewValley/Saves`，有则显示）、「Mod 文件夹」；高级：**删除当前版本**（仅 versions 根；确认「确认删除版本」，目录进回收站可恢复）或 **卸载 Base SMAPI**（确认「确认卸载 Base SMAPI」：移走 SMAPI 可执行文件、保留 Mods）；提示「Base 版本不可删除，仅可卸载其 SMAPI」 |
| **自动安装** | **安装 / 更改 SMAPI** |
| **Mod管理**（无空格，`VersionSettings.Nav.ModManage`） | 见 [Mod 管理](./Mod-Management) |
| **设置** | 窗口标题、启动参数、Steam 大厅、Steam 启动参数覆写；**无隔离开关** |
| **导出** | 见 [Modpack 整合包](./Modpack-Support)；清单默认不含 Mod 本体 |


## 版本级启动设置

版本设置 → **「设置」**（只对当前版本，自动保存；写入 Steam 需单独点按钮）：

| 项 | 说明 |
|----|------|
| **窗口标题** | 可含占位符；有帮助按钮 |
| **启动参数** | 当前版本 |
| **启动时尝试加入 Steam 大厅** | + **Steam 大厅 ID（64 位数字）**；提示「仅支持 Steam 大厅数字 ID；游戏内字母邀请码和 IP 地址仍需在联机菜单手动输入。」 |
| **Steam 启动参数覆写** | 可看默认参数；勾选 **覆盖 Steam 启动参数** 后编辑；按钮 **写入 Steam 启动参数** |

数据在 `instance-launch-settings.json`（与全局 `settings.json` 分离）。

## 启动相关

1. 版本选择中点选实例 → 回启动页 → **启动游戏**。  
2. 启动页信息卡**只读**展示：  
   - **启动模式**：自动 / SMAPI / 原版（`Launch.ModeValue.*`）  
   - **安全启动**：已开启 / 已关闭  
   - **状态**：如「未探测到本机游戏目录」  
   对应全局 `settings.json` 的 `PreferredLaunchMode`（默认「自动」）、`EnableSafeLaunch`。安装 SMAPI / 选实例等流程会改写；启动页本身不是编辑器。  
3. 实例级参数在版本设置 → **设置**（`instance-launch-settings.json`）。  
4. 仓库另有 `VersionSettingsContentView.axaml` 占位文案提到启动模式/安全启动，**不是**主版本设置页（主页为 `VersionSettingsPageView`）。

旧「双击卡片直接启动」：`InstancesPageView` **未见** DoubleTapped 绑定；请用启动页按钮。

## 隔离说明

- **不要**再写「设置页打开实例隔离」。
- 存档**不**随 Versions 目录隔离；概览 **存档文件夹** → `ApplicationData/StardewValley/Saves`（全实例共享）。
- 删版本 ≠ 删存档；删前备份 Mods 与存档。

---

## 相关文档

- [版本隔离](./Version-Isolation)
- [创建游戏实例](../tutorials/Creating-Instance)
- [SMAPI 管理](./SMAPI-Management)
- [设置与配置](./Settings)
