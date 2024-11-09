#!/bin/bash

# using one command line parameter

factorial=1

for (( n = 1; n < $1 ; n++ ))
do
	factorial=$[ $factorial * $n ]
done

echo The factorial of $1 is $factorial
