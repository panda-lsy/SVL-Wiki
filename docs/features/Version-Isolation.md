# 版本隔离

版本隔离让同一份游戏 **Base** 下可并存多套独立 Mods / SMAPI 运行时，而**存档仍走系统默认目录**（各实例共享）。

依据：`InstanceIsolationService`、`InstanceRuntimePathResolver`、CHANGELOG **[1.1.8.2]**。

## 目录

- [结论先看](#结论先看)
- [什么是版本隔离](#什么是版本隔离)
- [目录布局](#目录布局)
- [隔离范围](#隔离范围)
- [还有没有「启用隔离」开关？](#还有没有启用隔离开关)
- [与旧 Wiki 的矛盾](#与旧-wiki-的矛盾)
- [删除隔离实例](#删除隔离实例)

## 结论先看

| 问题 | 答案 |
|------|------|
| Mods 是否按实例分开？ | **是**（`Base/versions/<实例名>/Mods`） |
| 存档是否按实例分开？ | **否**（系统默认存档路径；可在概览打开存档文件夹） |
| 版本设置里能否开关隔离？ | **否**（1.1.8.2 已移除开关与开关触发的初始化） |
| Base 能否变成隔离实例？ | **Base 默认不可隔离**；装 SMAPI / 整合包时写入 `versions` 目录 |

## 什么是版本隔离

在 Base（Steam/GOG 等安装的原版目录）旁生成：

```text
<Base>/
└── versions/
    └── <实例名>/
        ├── Mods/          # 该实例独立 Mods
        ├── logs/          # 实例日志（若已创建）
        ├── Content/       # 常为指向 Base Content 的链接（旧/兼容布局）
        └── … SMAPI 与游戏运行文件（布局因版本而异）
```

运行目录解析：

- **新布局**：直接用 `versions/<名>`
- **旧布局**：若存在有效的 `versions/<名>/game`，则用该子目录

解析逻辑见 `InstanceRuntimePathResolver`。

## 目录布局

示意（简化）：

```text
Stardew Valley/                 # Base
├── Content/
├── Stardew Valley.exe / …      # 平台相关可执行文件
└── versions/
    ├── 农场整合/
    │   └── Mods/
    └── 测试包/
        └── Mods/
```

Content 等大资源尽量通过链接/共用，避免每实例整盘复制（具体是否 junction/symlink 取决于平台与安装路径）。

## 隔离范围

| 内容 | 是否隔离 | 说明 |
|------|----------|------|
| **Mods** | 是 | `GetIsolatedModsPath` → `versions/<名>/Mods` |
| **SMAPI 运行时（隔离实例）** | 是 | 安装到该版本目录；Base 也可装 SMAPI，语义不同 |
| **存档** | 否 | 注释写明：存档用系统默认路径 |
| **游戏 Content** | 共用 | 链接或共用 Base Content |
| **启动器全局设置** | 否 | `settings.json` |

## 还有没有「启用隔离」开关？

**没有（自 1.1.8.2）。**

CHANGELOG：

> 移除「版本隔离」开关及该开关触发的隔离初始化流程  
> Base 实例默认不可隔离；SMAPI 安装流程保持默认写入 `versions` 目录

因此：

- 不要再写「勾选启用版本隔离」类步骤。
- 新建带 SMAPI 的实例 / 导入整合包 → **默认落在隔离目录**。
- 数据模型里可能仍有 `EnableIsolation` 字段（迁移/扫描用），**UI 不再提供开关**。

## 与旧 Wiki 的矛盾

| 旧表述 | 应改为 |
|--------|--------|
| 「独立存档」为默认卖点 | **存档共享**；Mods 独立 |
| 「进入设置 → 启用实例隔离」 | **无此开关** |
| 可隔离「SMAPI 配置 / prefs」成套勾选表 | **待核实**细项；勿再画假勾选表 |
| Creating-Instance 写共享存档，本页写独立存档 | **以本页 + 源码为准：存档共享** |

## 删除隔离实例

版本设置 → **概览** → **「删除当前版本」**（Base 不可删，仅可卸载 Base 上的 SMAPI）。

删除会清理版本目录（含 Mods）；**不会删 Base 本体**。操作前请自行备份。

---

## 相关文档

- [创建游戏实例](../tutorials/Creating-Instance)
- [游戏实例管理](./Instance-Management)
- [SMAPI 管理](./SMAPI-Management)
- [设置与配置](./Settings)
