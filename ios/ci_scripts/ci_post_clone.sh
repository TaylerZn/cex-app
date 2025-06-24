#!/bin/sh

# Fail this script if any subcommand fails.
set -e

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.


if command -v flutter &> /dev/null; then
    echo "Flutter 已安装，版本号：$(flutter --version)"
else
    echo "Flutter 未安装"
    # 在此处添加安装 Flutter 的命令，例如：
    git clone https://github.com/flutter/flutter.git --depth 1 -b 3.19.0 $HOME/flutter
    export PATH="$PATH:$HOME/flutter/bin"
fi

# Install Flutter artifacts for iOS (--ios), or macOS (--macos) platforms.
flutter precache --ios

# Install Flutter dependencies.
flutter pub get

flutter pub global activate flutterfire_cli

if command -v pod &> /dev/null; then
    echo "CocoaPods 已安装"
    pod --version
else
    # Install CocoaPods using Homebrew.
    HOMEBREW_NO_AUTO_UPDATE=1 # disable homebrew's automatic updates.
    # 安装 Ruby
    echo "正在安装 Ruby..."
    brew install ruby

    # 获取 Ruby 安装路径
    RUBY_PATH=$(brew --prefix ruby)/bin/ruby
    RUBY_PATH_BIN=$(brew --prefix ruby)/bin
    # 获取 gem 路径
    GEM_PATH=$($RUBY_PATH -e 'puts Gem.default_dir')
     #配置brew 下的ruby
    export PATH="${RUBY_PATH_BIN}:$PATH"
    #配置 brew 下的gem的bin
    export PATH="${GEM_PATH}/bin:$PATH"
    # 安装 CocoaPods
    gem install cocoapods



fi
# Install CocoaPods dependencies.

# https://halo.ashine.free.hr/upload/Podfile.lock

touch developer.json

# 定义要修改的 Info.plist 文件路径
PLIST_FILE="${CI_PRIMARY_REPOSITORY_PATH}/ios/Runner/Info.plist"

# 新的版本号和 build 号
NEW_VERSION="1.0.3" #暂时写死,后期用环境变量
NEW_BUILD_NUMBER="3" #暂时写死,后期用环境变量

# 使用 PlistBuddy 修改版本号
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $NEW_VERSION" "$PLIST_FILE"

# 使用 PlistBuddy 修改 build 号
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $NEW_BUILD_NUMBER" "$PLIST_FILE"

echo "版本号和 build 号已更新：版本号=$NEW_VERSION，build 号=$NEW_BUILD_NUMBER"


# 下载配置文件
# curl -o ${CI_PRIMARY_REPOSITORY_PATH}/ios/Podfile.lock https://halo.ashine.free.hr/upload/Podfile.lock
git clone https://github.com/JHshine/fs $HOME/fs

cp -R $HOME/fs/Podfile.lock ${CI_PRIMARY_REPOSITORY_PATH}/ios/Podfile.lock

echo "Config file downloaded and saved to ${CI_PRIMARY_REPOSITORY_PATH}/ios/Podfile.lock "

cd ios && pod update Firebase/Crashlytics  # run `pod install` in the `ios` directory.


exit 0
