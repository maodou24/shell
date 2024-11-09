#!/bin/bash

var1=10
var2=20
var3=$(expr $var2 / $var1)

echo "the result of 20/10 is: $var3"
