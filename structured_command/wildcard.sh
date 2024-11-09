#!/bin/bash

# 通配符遍历目录

for file in /home/maodou/code/*
do
	if [ -d $file ]
	then
		echo "$file is a directory"
	elif [ -f $file ]
	then
		echo "$file is a file"
	fi
done
