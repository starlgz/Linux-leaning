#!/bin/bash

# 设置yt-dlp命令
YT_DLP_COMMAND="yt-dlp"

# 提示用户输入视频链接
echo "请输入视频链接:"
read -r video_url

# 获取视频缩略图 URL
thumbnail_url=$($YT_DLP_COMMAND --get-thumbnail "$video_url")

# 打印缩略图 URL
echo "视频缩略图 URL: $thumbnail_url"

# 用户选择是否下载缩略图，默认下载
read -p "是否下载缩略图？ (y/n, 默认为y): " download_thumbnail
download_thumbnail=${download_thumbnail:-y}

if [ "$download_thumbnail" == "y" ]; then
    # 下载并直接转换为JPEG格式
    $YT_DLP_COMMAND --write-thumbnail --skip-download "$video_url"
    echo "缩略图已下载！"
else
    echo "不下载缩略图。"
fi
