#!/bin/bash

# 通配符遍历目录

for file in /home/maodou/code/* /home/maodou/Downloads/*
do
	if [ -d "$file" ]
	then
		echo "$file is a directory"
	elif [ -f "$file" ]
	then
		echo "$file is a file"
	fi
done
