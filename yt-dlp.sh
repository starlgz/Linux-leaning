#!/bin/bash

YT_DLP_COMMAND="yt-dlp"

echo "请输入视频链接:"
read -r video_url

# 列出视频格式和质量选项
formats=$($YT_DLP_COMMAND -F "$video_url")

echo "可用视频格式和质量选项："
echo "$formats"

# 选择视频格式和质量
read -p "选择一个数字对应的视频格式和质量: " video_format_number

# 选择音频格式和质量
read -p "选择一个数字对应的音频格式和质量: " audio_format_number

# 下载视频
video_options="--format $video_format_number --merge-output-format mp4"
$YT_DLP_COMMAND "$video_url" $video_options -o "%(title)s_video.%(ext)s"

# 下载音频
audio_options="--format $audio_format_number --merge-output-format mp4"
$YT_DLP_COMMAND "$video_url" $audio_options -o "%(title)s_audio.%(ext)s"

# 合并视频和音频
ffmpeg -i "%(title)s_video.mp4" -i "%(title)s_audio.mp4" -c copy "%(title)s.mp4"

# 删除临时文件
rm "%(title)s_video.mp4" "%(title)s_audio.mp4"

echo "视频下载并合并完成！"
