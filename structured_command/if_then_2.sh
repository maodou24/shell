#!/bin/bash

if IamNotaCommand
then
	echo "It worked"
fi

echo "We are outside the if statement"


if pwd; then
	echo "another if statement worked"
fi
