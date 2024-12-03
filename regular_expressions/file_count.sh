#!/bin/bash

mypath=$(echo "$PATH" | sed 's/:/ /g')

echo $mypath

count=0
for dir in $mypath
do
	for file in $(ls $dir)
	do
		count=$[ $count + 1 ]
	done
	echo "$dir - $count"
	count=0
done
