#!/bin/bash

# 设置颜色变量
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 显示菜单选项
function show_menu() {
  echo -e "${YELLOW}作者：满天繁星${NC}"
  echo -e "${GREEN}1. 创建一个新的screen会话${NC}"
  echo -e "${GREEN}2. 列出所有已存在的screen会话${NC}"
  echo -e "${GREEN}3. 进入一个已存在的screen会话${NC}"
  echo -e "${GREEN}4. 在screen会话中进行操作${NC}"
  echo -e "${GREEN}5. 断开与screen会话的连接${NC}"
  echo -e "${GREEN}6. 重命名一个已存在的screen会话${NC}"
  echo -e "${GREEN}7. 删除一个已存在的screen会话${NC}"
  echo -e "${GREEN}8. 保存和恢复screen会话状态${NC}"
  echo -e "${GREEN}9. 配置screen会话的选项和参数${NC}"
  echo -e "${GREEN}10. 显示帮助和文档${NC}"
  echo -e "${RED}0. 退出脚本${NC}"
}

# 列出所有已存在的screen会话并编号
function list_sessions() {
  echo "所有已存在的screen会话："
  screen -ls | grep -o '[0-9]*\.[^ ]*' | awk '{print NR-1". "$0}'
}

# 读取用户输入
function read_choice() {
  read -p "请输入您的选择（0-10）：" choice
}

# 根据用户选择执行相应的操作
function do_action() {
  case $choice in
    1)
      read -p "请输入会话名称：" session_name
      screen -S $session_name
      ;;
    2)
      list_sessions
      ;;
    3)
      list_sessions
      read -p "请输入要进入的会话编号：" session_number
      session_name=$(screen -ls | grep -o '[0-9]*\.[^ ]*' | awk -v n=$session_number 'NR-1==n{print $2}')
      screen -r $session_name
      ;;
    4)
      echo "按下Ctrl + a，然后按下以下键进行操作："
      echo "c - 创建新窗口"
      echo "n - 切换到下一个窗口"
      echo "p - 切换到上一个窗口"
      echo "k - 关闭当前窗口"
      echo "| - 垂直分割窗口"
      echo "S - 水平分割窗口"
      echo "Tab - 切换分割窗口"
      echo "[ - 滚动屏幕"
      echo "q - 退出滚动模式"
      ;;
    5)
      echo "按下Ctrl + a，然后按下d，或者直接关闭终端窗口。"
      ;;
    6)
      read -p "请输入要重命名的会话名称：" old_session_name
      read -p "请输入新的会话名称：" new_session_name
      screen -S $old_session_name -X sessionname $new_session_name
      ;;
    7)
      read -p "请输入要删除的会话名称：" session_name
      screen -S $session_name -X quit
      ;;
    8)
      echo "按下Ctrl + a，然后按下以下键进行操作："
      echo "Ctrl + a，然后按下: - 进入命令模式"
      echo "Ctrl + a，然后按下:writebuf filename - 将当前屏幕缓冲区保存到文件中"
      echo "Ctrl + a，然后按下:readbuf filename - 从文件中恢复屏幕缓冲区"
      ;;
    9)
      echo "请参考相关文档和教程以深入了解更多关于screen的选项和参数。"
      ;;
    10)
      echo "请参考以下文档和教程以深入了解更多关于screen的功能和用法："
      echo "- 程序员真的很少写代码吗？ - 知乎 [4]"
      echo "- Bash脚本初学者完整教程 - Linux迷 [2]"
      echo "- 如何利用ChatGPT帮你写代码？-腾讯云开发者社区 - Tencent [3]"
      echo "- Shell 编程(七)：脚本实战-腾讯云开发者社区 [5]"
      echo "- Ubuntu下如何编辑开始菜单?Ubuntu下编辑开始菜单的方法 - 中企动力 [1]"
      ;;
    0)
      exit 0
      ;;
    *)
      echo -e "${RED}无效的选择。${NC}"
      ;;
  esac
}

# 循环显示菜单并读取用户输入
while true
do
  show_menu
  read_choice
  do_action
done
