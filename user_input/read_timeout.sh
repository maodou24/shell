#!/bin/bash

# read -t指定计时器

if read -t 5 -p "Please enter your name: " name
then
	echo "Hello $name, welcome to my script "
else
	echo
	echo "Sorry. too slow! "
fi
