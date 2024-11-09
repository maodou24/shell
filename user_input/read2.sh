#!/bin/bash

# read -p 命令行指定提示符

read -p "Please enter you age:" age
days=$[ $age * 365 ]
echo "That makes you over $days days old!"
