#!/bin/bash

exec 3>testfile

echo "This is a test line of data" >&3

echo 3>&-

