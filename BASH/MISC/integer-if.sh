#!/bin/bash

echo "Enter Num1:"
read num1

echo "Enter Num2:"
read num2

echo "What is $num1 * $num2 ?"
read num3

numTotal="$num1 * $num2"

if [[ "$numTotal" -eq "$num3" ]]
then

echo "Good Job!"

else

echo "Try again!"

fi
