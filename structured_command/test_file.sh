#!/bin/bash

# look before you leap

jump_directory=/home/maodou

if [ -d $jump_directory ]
then
	echo "the jump $jump_directory directory exists"
	cd $jump_directory
else 
	echo echo "the jump $jump_directory directory does not exists"
fi
