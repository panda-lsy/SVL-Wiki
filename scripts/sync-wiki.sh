#!/bin/bash

# SVL Wiki 同步脚本 (Bash 版本)
# 用于 GitHub Actions 或 Linux/Mac 系统

set -e

# 配置
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
TEMP_DIR="/tmp/svl-wiki-sync-$(date +%Y%m%d%H%M%S)"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

info() {
    echo -e "${CYAN}[INFO]${NC} $@"
}

success() {
    echo -e "${GREEN}[OK]${NC} $@"
}

warning() {
    echo -e "${YELLOW}[WARN]${NC} $@"
}

error() {
    echo -e "${RED}[ERROR]${NC} $@"
}

# 检查 Git
check_git() {
    if ! command -v git &> /dev/null; then
        error "Git 未安装或不可用"
        exit 1
    fi
    success "Git 版本：$(git --version)"
}

# 扁平化文件名
get_flat_filename() {
    local path="$1"
    # 移除 .md 后缀和路径前缀
    local clean_path="${path#./}"
    clean_path="${clean_path%.md}"
    clean_path="${clean_path//\\//}"
    
    # 转换 docs/ 路径
    if [[ "$clean_path" =~ ^docs/(.+)$ ]]; then
        echo "${BASH_REMATCH[1]//\//-}"
    else
        echo "$clean_path"
    fi
}

# 同步到 Wiki 仓库
sync_wiki_repo() {
    local name="$1"
    local url="$2"
    local ssh_url="$3"
    local use_ssh="$4"
    
    info "同步到 $name Wiki..."
    
    local wiki_dir="$TEMP_DIR/$name"
    
    # 选择 URL
    local repo_url="$url"
    if [[ "$use_ssh" == "true" && -n "$ssh_url" ]]; then
        repo_url="$ssh_url"
        info "  使用 SSH: $repo_url"
    else
        info "  使用 HTTPS: $repo_url"
    fi
    
    # 克隆仓库
    info "  克隆 $name Wiki..."
    if ! git clone "$repo_url" "$wiki_dir" &> /dev/null; then
        error "  克隆失败：$name"
        return 1
    fi
    
    # 清理旧文件
    cd "$wiki_dir"
    find . -maxdepth 1 -name "*.md" -delete
    
    # 收集文件映射
    declare -A file_mapping
    
    # 根目录 MD 文件
    for file in "$REPO_ROOT"/*.md; do
        if [[ -f "$file" ]]; then
            local filename=$(basename "$file")
            local base="${filename%.md}"
            
            if [[ "$filename" == "README.md" ]]; then
                file_mapping["README"]="Home"
            else
                file_mapping["$base"]="$base"
            fi
        fi
    done
    
    # docs 目录文件
    while IFS= read -r -d '' file; do
        local rel_path="${file#$REPO_ROOT/}"
        rel_path="${rel_path%.md}"
        local flat_name=$(get_flat_filename "$rel_path")
        
        file_mapping["$rel_path"]="$flat_name"
        file_mapping["./$rel_path"]="$flat_name"
        file_mapping["$rel_path.md"]="$flat_name"
    done < <(find "$REPO_ROOT/docs" -name "*.md" -print0 2>/dev/null)
    
    # 复制和转换文件
    info "  复制和转换文档..."
    
    for src_file in "$REPO_ROOT"/*.md "$REPO_ROOT"/docs/**/*.md; do
        if [[ -f "$src_file" ]]; then
            local rel_path="${src_file#$REPO_ROOT/}"
            local flat_name=$(get_flat_filename "$rel_path")
            local dest_file="$wiki_dir/$flat_name.md"
            
            # 复制并转换链接
            cp "$src_file" "$dest_file"
            
            # 转换链接
            for old_path in "${!file_mapping[@]}"; do
                local new_path="${file_mapping[$old_path]}"
                sed -i "s|\]($old_path)|]($new_path)|g" "$dest_file"
                sed -i "s|\]($old_path.md)|]($new_path)|g" "$dest_file"
            done
        fi
    done
    
    # 推送更改
    cd "$wiki_dir"
    
    git config user.name "SVL Bot"
    git config user.email "bot@svl.example.com"
    
    git add -A
    if git diff --staged --quiet; then
        info "  没有更改，跳过推送"
    else
        git commit -m "📝 同步 Wiki 文档 - $(date '+%Y-%m-%d %H:%M:%S')"
        
        if ! git push; then
            error "  推送失败：$name"
            return 1
        fi
        
        success "  推送成功：$name"
    fi
    
    return 0
}

# 主流程
main() {
    local use_ssh="false"
    local dry_run="false"
    local force="false"
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            --use-ssh|-ssh)
                use_ssh="true"
                shift
                ;;
            --dry-run|-n)
                dry_run="true"
                shift
                ;;
            --force|-f)
                force="true"
                shift
                ;;
            *)
                warning "未知参数：$1"
                shift
                ;;
        esac
    done
    
    echo "========================================"
    echo "  SVL Wiki 同步工具"
    echo "========================================"
    echo ""
    
    # 检查 Git
    check_git
    
    # 检查源文件
    if [[ ! -f "$REPO_ROOT/README.md" ]]; then
        error "找不到源文档：$REPO_ROOT"
        exit 1
    fi
    
    info "源目录：$REPO_ROOT"
    info "临时目录：$TEMP_DIR"
    
    if [[ "$dry_run" == "true" ]]; then
        warning "DRY-RUN 模式：不会实际推送"
    fi
    
    # 创建临时目录
    mkdir -p "$TEMP_DIR"
    
    # Wiki 仓库列表
    declare -A wikis
    wikis["SVL-Wiki"]="https://github.com/panda-lsy/SVL-Wiki.wiki.git|git@github.com:panda-lsy/SVL-Wiki.wiki.git"
    wikis["SVL-StardewValleyLauncher"]="https://github.com/panda-lsy/SVL-StardewValleyLauncher.wiki.git|git@github.com:panda-lsy/SVL-StardewValleyLauncher.wiki.git"
    wikis["Gitee-Wiki"]="https://gitee.com/mc_shengxia/SVL-StardewValleyLauncher.wiki.git|git@gitee.com:mc_shengxia/SVL-StardewValleyLauncher.wiki.git"
    
    local success_count=0
    local fail_count=0
    
    # 同步每个 Wiki
    for name in "${!wikis[@]}"; do
        IFS='|' read -r https_url ssh_url <<< "${wikis[$name]}"
        
        if sync_wiki_repo "$name" "$https_url" "$ssh_url" "$use_ssh"; then
            ((success_count++))
        else
            ((fail_count++))
        fi
        echo ""
    done
    
    # 清理
    info "清理临时文件..."
    rm -rf "$TEMP_DIR"
    
    # 总结
    echo "========================================"
    success "完成：$success_count 成功，$fail_count 失败"
    echo "========================================"
    
    if [[ $fail_count -gt 0 ]]; then
        exit 1
    fi
}

# 运行主流程
main "$@"
