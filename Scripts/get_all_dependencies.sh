#!/bin/bash

# 获取当前脚本的路径
SCRIPT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# 获取 Scripts 目录路径
SCRIPTS_DIR=$(dirname "$SCRIPT_PATH")

# 获取项目根路径
WORKSPACE=$SCRIPTS_DIR

echo "Script Path: $SCRIPT_PATH"
echo "Scripts Directory: $SCRIPTS_DIR"
echo "Workspace: $WORKSPACE"

# 遍历 deps 目录下的所有子目录
for dir in "$WORKSPACE/deps/"*; do
    if [ -d "$dir" ] && [ -f "$dir/pubspec.yaml" ]; then
        cd "$dir" || exit
        echo "Getting dependencies for $dir"
        flutter pub get
    fi
done

# 返回工作空间根目录并获取根项目依赖
cd "$WORKSPACE" || exit
echo "Getting dependencies for the root project"
flutter pub get

echo "All dependencies have been fetched successfully."
