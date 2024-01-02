#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

echo "请输入视频链接:"
read -r video_url

# 列出视频格式和质量选项
formats=$($YT_DLP_COMMAND -F "$video_url")

echo "可用视频格式和质量选项："
echo "$formats"

# 用户选择视频格式和质量
read -p "选择视频格式和质量 (如 22, 299+140): " video_format_number

# 列出功能选项（带颜色）
echo -e "\e[1;33m功能选项：\e[0m"
echo -e "1. \e[32m只下载音频\e[0m"
echo -e "2. \e[32m下载音频并转换成mp3\e[0m"
echo -e "3. \e[32m只下载视频\e[0m"
echo -e "4. \e[32m下载指定分辨率视频+音频\e[0m"
echo -e "5. \e[32m下载最佳mp4视频+最佳m4a音频并合成mp4\e[0m"
echo -e "6. \e[32m指定文件名下载\e[0m"

# 用户选择功能
read -p "选择功能 (1-6): " choice

case $choice in
    1)
        # 只下载音频
        $YT_DLP_COMMAND -f140 "$video_url"
        ;;
    2)
        # 下载音频并转换成mp3
        $YT_DLP_COMMAND -f140 -x --audio-format mp3 "$video_url"
        ;;
    3)
        # 只下载视频
        $YT_DLP_COMMAND -f22 "$video_url"
        ;;
    4)
        # 下载指定分辨率视频+音频
        $YT_DLP_COMMAND -f"$video_format_number" "$video_url"
        ;;
    5)
        # 下载最佳mp4视频+最佳m4a音频并合成mp4
        $YT_DLP_COMMAND -f 'bv[ext=mp4]+ba[ext=m4a]' --embed-metadata --merge-output-format mp4 "$video_url"
        ;;
    6)
        # 指定文件名下载
        read -p "请输入文件名 (不带扩展名): " file_name
        $YT_DLP_COMMAND -f"$video_format_number" "$video_url" -o "$file_name.mp4"
        ;;
    *)
        echo "无效的选择，请重新运行脚本。"
        exit 1
        ;;
esac

echo "操作完成！"
