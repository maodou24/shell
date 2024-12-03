#!/bin/bash

# using a global variable to pass a value

function func1 {
	value=$[ $value * 2 ]
}

read -p "Enter a value: " value

func1

echo "The new value is $value"

