#!/bin/bash

count=1
cat "read.sh" | while read line
do
	echo "Line $count: $line"
	count=$[ $count + 1 ]
done

echo "Finished processing the file"
