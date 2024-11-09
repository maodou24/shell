#!/bin/bash

# check if either a directory or file exists

location=$HOME
file_name="sentinel"


# -e 检查文件或者目录是否存在
if [ -e $location ]
then # directory does exists
	echo "OK on the $location directory"
	echo "Now checking on the file, $file_name"

	if [ -e $location/$file_name ]
	then # file exists
		echo "OK on the filename"
		echo "Updating current date..."
		date >> $location/$file_name
	else
		echo "File does not exists"
		echo "Nothing to update"
	fi
else
	echo "the directory does not exists"
	echo "Nothing to update"
fi
