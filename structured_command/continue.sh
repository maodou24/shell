#!/bin/bash

# continue提前中断某次循环

for (( var1=1; var1 < 15; var1++ ))
do
	if [ $var1 -gt 5 ] && [ $var1 -lt 10 ]
	then
		continue
	fi

	echo "Iteration number: $var1"
done
