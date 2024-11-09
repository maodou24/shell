#!/bin/bash

exec 3> testfile1
exec 6> testfile2
exec 7< testfile

/usr/bin/lsof -a -p $$ -d0,1,2,3,6,7
