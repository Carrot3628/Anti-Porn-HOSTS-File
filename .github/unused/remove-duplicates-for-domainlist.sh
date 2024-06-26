#!/bin/bash

# 定义hosts文件和域名列表文件的路径
HOSTS_FILE="HOSTS.txt"
DOMAIN_LIST_FILE="remove.txt"
TEMP_FILE=$(mktemp)

# 检查文件是否存在
if [ ! -f "$HOSTS_FILE" ]; then
  echo "Error: $HOSTS_FILE does not exist."
  exit 1
fi

if [ ! -f "$DOMAIN_LIST_FILE" ]; then
  echo "Error: $DOMAIN_LIST_FILE does not exist."
  exit 1
fi

# 读取域名列表并删除hosts文件中包含这些域名的行
while IFS= read -r domain; do
  grep -vw "$domain" "$HOSTS_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$HOSTS_FILE"
done < "$DOMAIN_LIST_FILE"

# 输出完成信息
echo "Completed: Entries containing domains from $DOMAIN_LIST_FILE removed from $HOSTS_FILE."
