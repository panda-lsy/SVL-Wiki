# 安装指南

本指南将帮助你下载和安装 SVL 启动器。

## 📋 目录

- [系统要求](#系统要求)
- [下载 SVL](#下载-svl)
- [安装步骤](#安装步骤)
- [常见问题](#常见问题)

## 系统要求

### 基本要求

| 项目               | 要求                                                       |
| ------------------ | ---------------------------------------------------------- |
| **操作系统** | Windows 7 SP1 及以上                                       |
| **运行时**   | .NET Framework 4.8（Windows 10+ 已内置，旧系统需手动安装） |
| **磁盘空间** | 100 MB（启动器）+ 游戏空间                                 |

### 游戏要求

- Stardew Valley 完整游戏部署
- 支持任意版本、任意来源（Steam、GOG、其他）

## 下载 SVL

### 下载源

SVL 提供两个下载源，可根据网络情况选择：

| 下载源           | 地址                                                                                                                      | 说明                 |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------- | -------------------- |
| **GitHub** | [github.com/panda-lsy/SVL-StardewValleyLauncher/releases](https://github.com/panda-lsy/SVL-StardewValleyLauncher/releases)   | 官方主仓库，国际访问 |
| **Gitee**  | [gitee.com/mc_shengxia/SVL-StardewValleyLauncher/releases](https://gitee.com/mc_shengxia/SVL-StardewValleyLauncher/releases) | 国内镜像，访问更快   |

### 版本类型

发布版本包含以下类型：

| 版本类型              | 说明                                             |
| --------------------- | ------------------------------------------------ |
| **Release**     | 稳定发布版，经过充分测试，推荐大多数用户使用     |
| **Pre-release** | 预发布版，包含最新功能和改进，可能存在不稳定因素 |

### 构建类型

每个版本提供两种构建：

| 构建类型               | 说明                         | 适用场景                 |
| ---------------------- | ---------------------------- | ------------------------ |
| **Release 构建** | 优化构建，无调试输出         | 日常使用，性能最优       |
| **Debug 构建**   | 包含日志输出和命令行调试信息 | 遇到问题时用于排查和反馈 |

### 下载步骤

1. 访问下载源（GitHub 或 Gitee）
2. 点击 **「Releases」** 标签
3. 选择合适的版本：
   - 推荐选择最新的 **Release** 版本
   - 想体验新功能可选择 **Pre-release** 版本
4. 在版本列表中下载对应的文件：
   - 日常使用：下载 `Release` 构建的 `.exe` 文件
   - 需要调试：下载 `Debug` 构建的 `.exe` 文件

## 安装步骤

### 使用便携版

SVL 是便携软件，无需安装：

1. 将下载的 `.exe` 文件保存到任意目录（如 `D:\Tools\SVL.Desktop.exe`）
2. 双击运行即可启动 SVL
3. 可选：右键创建快捷方式到桌面，方便后续使用

### Debug 版本注意事项

如果下载的是 Debug 构建：

- 启动时会显示命令行窗口
- 窗口中会输出详细的运行日志
- 遇到问题时，可以将日志截图或复制内容用于反馈

### 关联 NXM 协议

首次运行时，SVL 会提示是否关联 `nxm://` 协议。

关联后可以：

- 从 NexusMods 网站一键下载 Mod
- 浏览器点击直接打开 SVL

#### 测试协议关联

点击下面的按钮测试 NXM 协议是否已正确关联到 SVL：

<p align="center">
  <a href="nxm://test/link">
    <img src="https://img.shields.io/badge/🧪_测试_NXM_协议-Click_Here-blue?style=for-the-badge" alt="测试 NXM 协议">
  </a>
</p>

> **注意**：此链接仅用于测试协议关联，不会下载任何实际的 Mod。

## 常见问题

### Q: 提示缺少 .NET Framework 4.8

**A:** Windows 10 1903+ 和 Windows 11 已内置。如需安装：

1. 访问 [Microsoft 下载中心](https://dotnet.microsoft.com/download/dotnet-framework/net48)
2. 下载并安装

### Q: 启动器无法启动

**A:** 尝试以下步骤：

1. 以管理员身份运行
2. 检查杀毒软件是否拦截
3. 重新下载最新版本

### Q: 如何更新 SVL？

**A:**

1. SVL 会自动检查更新
2. 也可以手动下载新版本覆盖

---

## 下一步

- [初次使用指南](./Getting-Started)
- [创建游戏实例](./Creating-Instance)
- [安装 Mod](./Installing-Mods)
