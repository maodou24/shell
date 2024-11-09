#!/bin/bash

while  [ -n "$1" ]
do
    case "$1" in
      -a) echo "Found the -a option" ;;
      -b) echo "Found the -b option" ;;
      -c) echo "Found the -c option" ;;
      --) shift
	      break ;;
       *) echo "$1 is not an option" ;;
    esac
    shift
done

for param in "$@"
do
	echo "Parameter: $param "
done



