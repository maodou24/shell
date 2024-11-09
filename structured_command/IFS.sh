#!/bin/bash

# bash shell 会将空格，制表符，换行符当做分隔符

list="a, b, c, d, e, f"

IFSOLD=$IFS
IFS=','

for test in $list
do
	echo "$test"
done

IFS=$IFSOLD
