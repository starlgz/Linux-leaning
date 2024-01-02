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

# 设置输出文件名
read -p "请输入输出文件名 (不包含扩展名): " output_filename

# 下载视频
video_options="--format $video_format_number --merge-output-format mp4"
$YT_DLP_COMMAND "$video_url" $video_options -o "${output_filename}_video.%(ext)s"

# 下载音频
audio_options="--format $audio_format_number --merge-output-format mp4"
$YT_DLP_COMMAND "$video_url" $audio_options -o "${output_filename}_audio.%(ext)s"

# 合并视频和音频
ffmpeg -i "${output_filename}_video.mp4" -i "${output_filename}_audio.mp4" -c copy "${output_filename}.mp4"

# 删除临时文件
rm "${output_filename}_video.mp4" "${output_filename}_audio.mp4"

echo "视频下载并合并完成！"
