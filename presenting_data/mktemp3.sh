#!/bin/bash

# temp directory

tempdir=$(mktemp -d dir.XXXXXX)

cd $tempdir

tempfile1=$(mktemp temp.XXXXXX)
tempfile2=$(mktemp temp.XXXXXX)

exec 7> $tempfile1
exec 8> $tempfile2

echo "Sending data to directory $tempdir"
echo "This is test line of data for $tempfile1" >&7
echo "This is test line of data for $tempfile2" >&8

echo $(ls -al)

