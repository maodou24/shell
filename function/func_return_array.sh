#!/bin/bash

function func1 {
	local array=(1 2 3 4 5)
	echo "${array[*]}"
}

newarray=$(func1)

echo "new array: ${newarray[*]}"
