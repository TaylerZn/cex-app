#!/bin/bash

# 获取当前脚本的路径
SCRIPT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# 获取 Scripts 目录路径
SCRIPTS_DIR=$(dirname "$SCRIPT_PATH")

# 获取项目根路径
WORKSPACE=$SCRIPTS_DIR
cd ${WORKSPACE}

flutter build apk --release


KToken="EooSeIofc5u5vbTWXzDF9a4ev6d1NefSs41N1DXEXW"
#KProductPath="${WORKSPACE}/build/ios/ipa/newpayvarapp.ipa"
KEmails="xiaoguo@arklarb.com,bob@arklarb.com,Olane@arklarb.com,Ricky@gmail.com"

KProductPath="${WORKSPACE}/build/app/outputs/flutter-apk/app-release.apk"


KJob=$(curl -s https://upload.diawi.com/ \
  -F token="${KToken}" \
  -F file=@"${KProductPath}" \
  -F find_by_udid=1 \
  -F comment="分支:$(git rev-parse --abbrev-ref HEAD)-$(git log -1 --pretty=format:'%s')" \
  -F callback_emails="${KEmails}" | jq -r '.job')


# KJob="57crXJTFnVakOOgBLjUjkHgDa3uVRbCjkI2SLzUuYS"

sleep 15

curl  "https://upload.diawi.com/status?token=${KToken}&job=${KJob}" | jq .