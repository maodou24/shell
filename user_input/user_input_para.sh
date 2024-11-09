#!/bin/bash

echo $#

if [ $1 -ne 2 ]
then
	echo
	echo "Usage: $0.sh a b"
	echo
else
	total=$[ $1 + $2 ]
	echo
	echo The totoal is $total
	echo
fi
