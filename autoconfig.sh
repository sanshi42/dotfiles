#!/usr/bin/env sh

# 确保 find 结果按行处理，兼容 zsh 和 bash
files=$(find . -maxdepth 1 -name ".*" -type f | grep -v .gitignore)

# 遍历文件
for file in $files; do
    file=$(basename "$file")  # 获取文件名
    target="$HOME/$file"      # 目标软链接路径
    source="$(pwd)/$file"     # 源文件完整路径

    echo "Processing: $source"

    # 检查目标路径是否已经存在
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "⚠️  跳过: $target 已存在"
        continue
    fi

    # 创建软链接
    ln -s "$source" "$target"
    echo "✅ 已创建软链接: $target -> $source"
done
