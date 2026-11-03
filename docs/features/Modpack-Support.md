# Modpack 整合包

导入、搜索安装与**导出**整合包。导出默认按来源清单分发，**不含 Mod 本体文件**。

源码：`ModpackInstallService`、`VersionSettingsPageView` 导出段、`InstancesPageView` **「导入整合包」**、下载页 Modpack 类别。

## 目录

- [支持的格式](#支持的格式)
- [导入](#导入)
- [从下载页安装](#从下载页安装)
- [导出](#导出)
- [包内结构（SVL）](#包内结构svl)
- [注意](#注意)

## 支持的格式

| 类型 | 识别要点 |
|------|----------|
| **SVL** | 含 `modpack.json`（常配合 `sources.json`）；zip 或已解压目录 |
| **CurseForge** | `manifest.json`；`.zip` / `.cfmodpack`（仍按 zip 处理） |
| **Nexus Collection** | Collection 安装链路（并行度等受设置约束） |

第三方变体若缺 `sources.json`，安装器会尝试与 `modpack.json.mods` 合并来源字段（兼容逻辑以源码为准）。

## 导入

1. **版本选择** → 路径操作 **「导入整合包」**。  
2. 或把整合包 zip **拖入**启动器（若当前版本支持该拖放路径）。  
3. 按向导选 Base / 实例名等。  
4. 进度在 **「任务」** 查看。

装完后通常得到 `versions/<名>/` 隔离实例（Mods 独立；存档仍共享，见 [版本隔离](./Version-Isolation)）。

## 从下载页安装

导航 **「下载」** → 类别 **Modpack** → 搜索页或 URL 导入（文案：`Download.Modpack.*`）。

## 导出

**版本设置 →「导出」**：

| 字段 / 勾选 | 说明 |
|-------------|------|
| 整合包名称 / 版本 / 作者 | 写入清单 |
| **导出 Mod 清单**（`IncludeMods`，默认开） | 写入 `modpack.json` + `sources.json` 条目；**不是**打包 dll/资源本体 |
| **导出 Mod 配置文件** | `settings/Mods/...` 下 config 等 |
| **导出当前 SVL 启动器文件**（默认关） | 外层带启动器的增强包格式 |
| **导出当前整合包** | 另存为 `.zip` |
| 保存/读取配置 | `.svlexport` / `.json` |

源码注明：`导出包不包含 Mod 本体，仅包含清单与可选配置`；`sources` 里 `Bundled = false`。导入端按来源再下载。

无完整来源凭证的条目会标需手动安装 / 导入时兼容处理。

## 包内结构（SVL）

典型可回导包：

```text
modpack.json          # 名称、版本、SMAPI 提示、mods 列表
sources.json          # 平台 / projectId / fileId 等
export-manifest.json  # 导出审计信息（安装以 modpack+sources 为准）
settings/Mods/...     # 可选：Mod 配置
icon.png              # 可选：实例图标
```

带启动器的包：外层启动器 + 内层 `modpack.zip`（与普通平铺包不同）。

## 注意

- 分享清单包需接收方能访问 Nexus/CF 等来源，并遵守平台条款。  
- 导出前宜登录 Nexus，便于补全缺失 FileID。  
- 删改 Base / 实例前先备份。

---

## 相关文档

- [创建游戏实例](../tutorials/Creating-Instance)
- [版本隔离](./Version-Isolation)
- [下载管理器](./Download-Manager)
