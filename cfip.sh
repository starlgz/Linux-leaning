#!/bin/bash

# 设置Telegram机器人API令牌
read -p "请输入Telegram机器人API令牌: " telegram_bot_token
# 设置Telegram用户ID
read -p "请输入Telegram用户ID: " telegram_user_id

# 设置参数
read -p "设置最小速度（kB/s）: " speed
read -p "设置数据中心: " colo
read -p "设置最大延迟（ms）: " maxms
read -p "设置每个域名A记录数量: " num
read -p "TLS端口: " tlsport
read -p "非TLS端口: " notlsport
read -p "是否启用TLS（1-启用，0-禁用）: " tls

chmod +x iptest

while true
do
    n=0
    startdate=$(date -u -d"+8 hour" +'%Y%m%d')

    if [ $tls == 1 ]
    then
        protocol="https"
        port=$tlsport
    else
        protocol="http"
        port=$notlsport
    fi

    ./iptest -port=$port -outfile=$port.csv -max=50 -tls=$tls -speedtest=0
    grep $colo $port.csv | awk -F, -v maxms="$maxms" '$7 <= maxms {print $1}' > $port.txt
    ./iptest -file=$port.txt -port=$port -outfile=ip.csv -max=50 -tls=$tls -speedtest=2

    for i in $(awk -F, -v speed="$speed" '$8 >= speed {print $1}' ip.csv)
    do
        if [ "$(date -u -d"+8 hour" +'%Y%m%d')" == "$startdate" ]
        then
            http_code=$(curl -A "" --retry 2 --resolve cp.cloudflare.com:$port:$i -s $protocol://cp.cloudflare.com:$port -w %{http_code} --connect-timeout 2 --max-time 3)

            if [ "$http_code" == "204" ]
            then
                echo "$(date +'%H:%M:%S') $i 状态正常"

                while read -r ipinfo
                do
                    echo 更新域名
                    old_ip=$(curl -s https://api.cloudflare.com/client/v4/zones/$(echo $ipinfo | awk -F- '{print $3}')/dns_records/$(echo $ipinfo | awk -F- '{print $4}') -H "Authorization: Bearer $bearer" -H "Content-Type: application/json" | jq -r '.result.content')
                    curl -s --retry 3 -X PUT "https://api.cloudflare.com/client/v4/zones/$(echo $ipinfo | awk -F- '{print $3}')/dns_records/$(echo $ipinfo | awk -F- '{print $4}')" -H "Authorization: Bearer $bearer" -H "Content-Type:application/json" --data '{"type":"A","name":"'"$(echo $ipinfo | awk -F- '{print $2}')"'","content":"'"$i"'","ttl":60,"proxied":false}'
                    
                    # Telegram消息推送
                    message="IP地址更换:\n旧IP: $old_ip\n新IP: $i\n位置: $colo\n速度: $speed kB/s\n延迟: $maxms ms"
                    curl -s -X POST "https://api.telegram.org/bot$telegram_bot_token/sendMessage" -d "chat_id=$telegram_user_id&text=$message"
                    
                    echo 故障推送telegram
                done < <(grep -w $i ddns.txt | tr -d '\r' | awk '{print $1"-"$2"-"$3"-"$4}')

                # ...（其余部分与之前的脚本相同）
            fi
        else
            echo 新的一天开始了
            break
        fi
    done
done
