#!/bin/bash

tempfile=$(mktemp -t test.XXXXXX)

exec 3>$tempfile

echo "This is test file." > $tempfile
echo "This is the second line" > $tempfile

echo "The temp file is located at: $tempfile"
cat $tempfile

rm -f $tempfile
