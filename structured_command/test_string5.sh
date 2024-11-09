#!/bin/bash

# 比较字符串大小写
# 大写字母小于小写字母

var1=Testing
var2=testing

if [ $var1 \> $var2 ]
then
	echo "$var1 is greater than $var2"
else
	echo "$var1 is less than $var2"
fi
