#!/bin/bash

# 比较浮点值大小

value1=5.555

echo "The test value is $value1"

if [ $value1 -gt 5 ]
then
	echo "The test value $value1 is greater than 5"
fi

# failed, bash shell只能处理整数，不能test命令中使用浮点值
