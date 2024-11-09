#!/bin/bash

# 使用[]将数学表达式围起来

# 计算 100 * （50-45）

var1=100
var2=50
var3=45

var4=$[$var1 * ($var2 - $var3)]
echo "the final result is $var4"
