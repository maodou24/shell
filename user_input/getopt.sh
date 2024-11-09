#!/bin/bash

set -- $(getopt ab:cd "$@")

while  [ -n "$1" ]
do
    case "$1" in
      -a) echo "Found the -a option" ;;
      -b) param=$2
	      echo "Found the -b option, with the parameter value $param"
	      shift ;;
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



