#!/bin/bash

# 会将反引号或者$()里面的内容当成一条命令使用

d=`date`

echo "The data and time are: $d"

today=$(date +%y%m%d)
ls /usr/bin -al > log.$today
