#!/bin/bash

while  [ -n "$1" ]
do
    case "$1" in
      -a) echo "Found the -a option" ;;
      -b) param=$2
	     echo "Found the -b option, with Parameter value $param"
	     shift ;;
      -c) echo "Found the -c option" ;;
      --) shift
	      break ;;
       *) echo "$1 is not an option" ;;
    esac
    shift
done


