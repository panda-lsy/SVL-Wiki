# Modpack 整合包

SVL 支持多种整合包格式，让你可以轻松分享和导入 Mod 配置。

## 📋 目录

- [支持的格式](#支持的格式)
- [创建整合包](#创建整合包)
- [导入整合包](#导入整合包)
- [整合包内容](#整合包内容)
- [分享整合包](#分享整合包)

## 支持的格式

SVL 支持以下整合包格式：

| 格式                       | 扩展名                    | 说明                                |
| -------------------------- | ------------------------- | ----------------------------------- |
| **SVL Modpack**      | `.zip`                  | SVL 原生格式，包含 `modpack.json` |
| **CurseForge**       | `.zip` / `.cfmodpack` | 包含 `manifest.json`              |
| **Nexus Collection** | `.7z`                   | 包含 `collection.json`            |

## 创建整合包

> **⚠️ 重要提示：关于“打包 Mod 文件”功能的说明**
> 目前 Wiki 内容（除在主页标注进度为 100% 的内容外）还需进行人工审核修订，一切请以启动器实际功能为准。
>
> **导出整合包功能已不支持直接打包 Mod 文件**。启动器目前在开发阶段，但以尊重创作者的劳动成果为准，正式移除了“打包 Mod 文件”选项，只保留注明来源的 Modlist 导出，直到后续有更合理的以创作者为主的传播方式。
>
> 整合包导出的内容为：游戏实例中可以检测到来源的 Mod 将作为一份清单（内含模组的来源 ID），实际打包的只有配置文件（`config.json`）以及该 Mod 清单。在别人导入该整合包后，启动器会自动解析清单中的 Mod 并进行在线下载。

### 步骤

1. 选择要导出的实例
2. 进入实例设置 → **「导出」** 选项卡
3. 选择要包含的内容：
   - ✅ Mod 配置文件
   - ✅ 游戏设置
   - ✅ SMAPI 版本信息
4. 点击 **「导出」**
5. 选择保存位置

### 导出选项

| 选项                     | 说明                                                                     |
| ------------------------ | ------------------------------------------------------------------------ |
| **仅保存下载链接** | 生成 Mod 清单，只保存 Mod 的下载源信息（导入时启动器自动解析清单并下载） |
| **包含截图**       | 添加整合包预览图                                                         |
| **压缩级别**       | 选择压缩质量                                                             |

### modpack.json 结构

```json
{
  "name": "我的整合包",
  "version": "1.0.0",
  "author": "作者名",
  "description": "整合包描述",
  "gameVersion": "1.6.8",
  "smapiVersion": "4.1.1",
  "mods": [
    {
      "id": "Pathoschild.SMAPI",
      "name": "SMAPI",
      "version": "4.1.1",
      "enabled": true
    }
  ]
}
```

## 导入整合包

### 拖放导入

1. 将整合包文件拖放到启动器窗口
2. 输入新实例名称
3. 等待安装完成

### 菜单导入

1. 点击主页的 **「+」** 按钮
2. 选择 **「导入整合包」**
3. 选择整合包文件
4. 输入实例名称
5. 等待安装完成

### 安装流程

```
1. 解析整合包清单
      ↓
2. 安装 SMAPI（如需要）
      ↓
3. 解压/下载 Mod 文件
      ↓
4. 应用 Mod 配置
      ↓
5. 保存实例信息
      ↓
6. 完成！
```

## 整合包内容

### SVL Modpack 结构

```
my-modpack.zip
├── modpack.json          # 整合包清单
├── sources.json          # Mod 下载源（可选）
├── preview.png           # 预览图（可选）
└── settings/             # 配置文件（可选）
    └── config.json
```

### CurseForge 格式

```
curseforge-pack.zip
├── manifest.json         # CurseForge 清单
├── modlist.html          # Mod 列表（HTML）
└── override/             # 覆盖文件
```

### Nexus Collection 格式

```
collection.7z
├── collection.json       # Collection 元数据
├── modlist.json          # Mod 列表
└── ...                   # 其他文件
```

## 分享整合包

### 上传到 GitHub

1. 创建 GitHub Release
2. 上传整合包文件
3. 添加描述和截图
4. 发布

### 分享到社区

- NexusMods Collections
- CurseForge Modpacks
- QQ群 / Discord
- 论坛帖子

### 注意事项

- ⚠️ 确保所有 Mod 允许重新分发
- ⚠️ 检查 Mod 许可证
- ⚠️ 注明原作者信息
- ⚠️ 提供支持的 SMAPI / 游戏版本

---

## 相关文档

- [Mod 管理](./Mod-Management)
- [NexusMods 集成](./NexusMods-Integration)
- [创建游戏实例](../tutorials/Creating-Instance)
