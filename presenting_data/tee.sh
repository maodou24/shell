#!/bin/bash

# using tee

tempfile=testfile

echo "This is the start line of the test" | tee "$tempfile"
echo "This is the second line of the test" | tee -a $tempfile

echo
echo "cat file"
cat $tempfile

rm -f $tempfile
