#!/bin/bash

# 命令替换运行bc命令
# bc bash计算器
# 基本格式如下
# variable=$(echo "options; expression" | bc)

echo test1
var=$(echo "scale=4; 3.44 / 5" | bc)
echo The answer is $var

echo test2
var1=100
var2=45
var3=$(echo "scale=4; $var1 / $var2" | bc)
echo the answer is $var3

echo test3
var1=20
var2=3.14159
var3=$(echo "scale=4; $var1 * $var1" | bc)
var4=$(echo "scale=4; $var3 * $var2" | bc)
echo the answer is $var4




