#!/bin/bash

# using case command

case $USER in
maodou)
	echo "Welcome, $USER"
	echo "Please enjoy you visit";;  # ;;标识case的结尾
testing)
	echo "testing account";;
*)
	echo "sorry, you are not allowed here";;  # default command
esac
