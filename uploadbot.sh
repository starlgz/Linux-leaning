#!/bin/bash

# 获取Telegram Bot API令牌
read -p "请输入Telegram Bot的API令牌: " TELEGRAM_BOT_TOKEN

# 获取目标私人群组ID
read -p "请输入目标私人群组ID: " TELEGRAM_GROUP_ID

# 获取VPS上视频文件的路径
read -p "请输入VPS上视频文件的路径: " VIDEO_FILE_PATH

# 发送视频到Telegram群组的函数
send_video_to_telegram() {
    local video_path="$1"
    local bot_token="$2"
    local chat_id="$3"

    # 发送视频
    curl -F "chat_id=${chat_id}" \
         -F "video=@${video_path}" \
         -H "Content-Type: application/json" \
         "https://api.telegram.org/bot${bot_token}/sendVideo"
}

# 调用函数发送视频，并显示进度
echo -n "正在发送视频"
send_video_to_telegram "$VIDEO_FILE_PATH" "$TELEGRAM_BOT_TOKEN" "$TELEGRAM_GROUP_ID" &
pid=$!

while kill -0 $pid 2> /dev/null; do
    echo -n "."
    sleep 1
done

echo ""

# 删除本地视频文件（可选）
read -p "是否删除本地视频文件？(y/n): " DELETE_LOCAL_FILE
if [ "$DELETE_LOCAL_FILE" == "y" ]; then
    rm "$VIDEO_FILE_PATH"
    echo "本地视频文件已删除."
fi

echo "脚本执行完毕."
