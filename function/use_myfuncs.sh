#!/bin/bash

# ../myfuncs
source myfuncs

value1=10
value2=5

result1=$(addem $value1 $value2)
result2=$(multem $value1 $value2)
result3=$(divem $value1 $value2)

echo "The result of adding them is: $result1"
echo "The result of multem them is: $result2"
echo "The result of divem them is: $result3"
