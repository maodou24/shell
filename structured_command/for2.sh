#!/bin/bash

# 列表中的复杂值
# 转移字符转义特殊字符
# 使用双引号定义用到单引号的值

for test in I don\'t know if "this'll" work
do
	echo "word: $test"
done
