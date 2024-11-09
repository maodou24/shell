#!/bin/bash

# redirecting input file description

# 描述符6保存STDIN
exec 6<&0
# 描述符6重定向到文件
exec 0<testfile

count=1
while read line
do
	echo "Line $count: $line"
done

# 描述符0恢复STDIN
exec 0<&6

read -p "Are you done now? " answer
case $answer in
	Y|y) echo "Goodbye" ;;
	N|n) echo "Sorry, this is the end." ;;
esac
