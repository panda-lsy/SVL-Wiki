#!/bin/bash
# 模拟 GitHub Actions 中的扁平化逻辑

set -e

echo "📦 准备扁平化的 Wiki 文件..."

# 清理旧的测试输出
rm -rf wiki-output
mkdir -p wiki-output

# 复制 images 文件夹
if [ -d "images" ]; then
    cp -r images wiki-output/
fi

# 处理根目录的 MD 文件
for file in *.md; do
    if [ -f "$file" ]; then
        if [ "$file" = "README.md" ]; then
            cp "$file" wiki-output/Home.md
            echo "  根目录: $file -> Home.md"
        else
            cp "$file" "wiki-output/$file"
            echo "  根目录: $file -> $file"
        fi
    fi
done

# 处理 docs 目录下的文件（扁平化）
if [ -d "docs" ]; then
    find docs -name "*.md" -type f | while read file; do
        # 移除 docs/ 前缀和 .md 后缀
        relative="${file#docs/}"
        relative="${relative%.md}"
        # 替换 / 为 -
        flat_name="${relative//\//-}"
        
        cp "$file" "wiki-output/${flat_name}.md"
        echo "  docs: $file -> ${flat_name}.md"
    done
fi

echo ""
echo "✅ 文件准备完成"
echo ""
echo "扁平化后的文件列表:"
ls -la wiki-output/

echo ""
echo "📝 更新链接引用..."

cd wiki-output

for md_file in *.md; do
    if [ -f "$md_file" ]; then
        # 使用 perl 替代 sed，更可靠地处理链接
        perl -i -pe '
            # 更新 docs/tutorials/ 链接
            s/\[([^\]]+)\]\(\.?\/?docs\/tutorials\/([^)\.]+)(\.md)?\)/[$1](tutorials-$2)/g;
            # 更新 docs/features/ 链接
            s/\[([^\]]+)\]\(\.?\/?docs\/features\/([^)\.]+)(\.md)?\)/[$1](features-$2)/g;
            # 更新 docs/development/ 链接
            s/\[([^\]]+)\]\(\.?\/?docs\/development\/([^)\.]+)(\.md)?\)/[$1](development-$2)/g;
            # 更新 docs/CONTRIBUTING 链接
            s/\[([^\]]+)\]\(\.?\/?docs\/CONTRIBUTING(\.md)?\)/[$1](CONTRIBUTING)/g;
            # 更新 README 链接为 Home
            s/\[([^\]]+)\]\(\.?\/?README(\.md)?\)/[$1](Home)/g;
        ' "$md_file"
        
        echo "  已处理: $md_file"
    fi
done

echo ""
echo "✅ 链接更新完成"
echo ""
echo "示例链接转换:"
echo "  [安装指南](./docs/tutorials/Installation) -> [安装指南](tutorials-Installation)"
echo "  [Mod 管理](docs/features/Mod-Management) -> [Mod 管理](features-Mod-Management)"
echo "  [首页](./README) -> [首页](Home)"

