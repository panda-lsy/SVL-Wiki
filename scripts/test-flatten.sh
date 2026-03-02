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

# 创建链接映射文件
declare -A file_map

# 处理根目录的 MD 文件
for file in *.md; do
    if [ -f "$file" ]; then
        if [ "$file" = "README.md" ]; then
            cp "$file" wiki-output/Home.md
            file_map["./README"]="Home"
            file_map["README"]="Home"
            echo "  根目录: $file -> Home.md"
        else
            base=$(basename "$file" .md)
            cp "$file" "wiki-output/$file"
            file_map["./$base"]="$base"
            file_map["$base"]="$base"
            echo "  根目录: $file -> $file"
        fi
    fi
done

# 处理 docs 目录下的文件（扁平化）
if [ -d "docs" ]; then
    find docs -name "*.md" -type f | while read file; do
        # 移除 docs/ 前缀和 .md 后缀
        relative=${file#docs/}
        relative=${relative%.md}
        # 替换 / 为 -
        flat_name=${relative//\//-}
        
        cp "$file" "wiki-output/${flat_name}.md"
        
        echo "  docs: $file -> ${flat_name}.md"
    done
fi

# 更新所有链接
echo ""
echo "📝 更新链接引用..."
cd wiki-output
for md_file in *.md; do
    if [ -f "$md_file" ]; then
        # 创建备份
        cp "$md_file" "${md_file}.bak"
        
        # 更新 docs/ 路径的链接
        sed -i -E 's|\[([^\]]+)\]\(\.?/?docs/([^)]+)\)|[\1](\2)|g' "$md_file"
        sed -i -E 's|\[([^\]]+)\]\(\.?/?docs/([^)]+)\.md\)|[\1](\2)|g' "$md_file"
        
        # 替换路径中的 / 为 -
        sed -i -E 's|\[([^\]]+)\]\((tutorials|features|development|CONTRIBUTING)/([^)]+)\)|[\1](\2-\3)|g' "$md_file"
        sed -i -E 's|\[([^\]]+)\]\((tutorials|features|development|CONTRIBUTING)/([^)]+)\.md\)|[\1](\2-\3)|g' "$md_file"
        
        # 更新 README 链接为 Home
        sed -i -E 's|\[([^\]]+)\]\(\.?/?README\)|[\1](Home)|g' "$md_file"
        sed -i -E 's|\[([^\]]+)\]\(\.?/?README\.md\)|[\1](Home)|g' "$md_file"
        
        # 检查是否有变化
        if ! diff -q "${md_file}.bak" "$md_file" > /dev/null 2>&1; then
            echo "  已更新: $md_file"
        fi
        
        # 删除备份
        rm "${md_file}.bak"
    fi
done

echo ""
echo "✅ 文件准备完成"
echo ""
echo "扁平化后的文件列表:"
ls -la

echo ""
echo "示例链接转换:"
echo "  [安装指南](./docs/tutorials/Installation) -> [安装指南](tutorials-Installation)"
echo "  [Mod 管理](docs/features/Mod-Management) -> [Mod 管理](features-Mod-Management)"
echo "  [首页](./README) -> [首页](Home)"
