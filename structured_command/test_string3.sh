#!/bin/bash

# test中使用(>)需要使用转移字符，否则认为是重定向

var1=baseball
var2=hockey

if [ $var1 > $var2 ]
then
	echo "$var1 is greater than $var2"
else
	echo "$var1 is less than $var2"
fi
