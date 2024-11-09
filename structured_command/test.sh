#!/bin/bash

# 复合条件测试
# [ codition1 ] && [ condition2 ]  或者 [ codition1 ] || [ condition2 ]

touch $HOME/testing

if [ -d $HOME ] && [ -w $HOME/testing ]
then
	echo "the file exists and you can write it"
else
	echo "I cannot write to the file"
fi

rm $HOME/testing
