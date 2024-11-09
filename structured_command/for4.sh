#!/bin/bash

file="temp.txt"

"a b c d e f" > $file

for test in $(cat $file)
do
	echo "$test"
done

rm $file
