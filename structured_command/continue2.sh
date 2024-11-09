#!/bin/bash

# continue提前中断某次循环

for (( var1=1; var1 < 5; var1++ ))
do
	echo  "Outer number: $var1"

	for (( var2=1; var2 < 3; var2++ ))
	do
		if [ $var1 -gt 2 ] && [ $var2 -lt 4 ]
		then
			continue 2
		fi
		echo "	Inner number: $var2"
	done
done
