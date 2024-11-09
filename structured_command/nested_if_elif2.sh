#!/bin/bash

# testing nested ifs - user elif

testuser=NoSuchUser

if grep $testuser /etc/passwd
then
	echo "the user $testuser exists on this system"

elif ls -d /home/$testuser
then
	echo "The user $testuser does not exist on this system."
	echo "However, $testuser has a directory."
else
	echo "The user $testuser does not exist on this system."
	echo "And, $testuser does not have a directory"
fi
