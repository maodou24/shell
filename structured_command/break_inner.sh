#!/bin/bash

# 使用break退出循环
# 退出内部循环

for (( a = 1; a < 4; a++ ))
do
	echo "Outer loop: $a"
	for (( b = 1; b < 100; b++ ))
	do
		if [ $b -eq 5 ]
		then
			break
		fi
	
		echo "	Inner loop: $b"
	done
done
