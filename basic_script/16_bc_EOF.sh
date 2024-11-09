#!/bin/bash

# 内里输入重定向

var1=20
var2=3
var3=5

var4=$(bc << EOF
scale = 4
a = ($var1 + $var2)
b = ($var1 - $var3)
a + b
EOF
)

echo the final result is $var4
