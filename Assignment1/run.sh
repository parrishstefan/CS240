#!/bin/bash

#Program: Assignment 1: Area of Rectangle
#Author: Stefan Parrish

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble assignment1.asm"
nasm -f elf64 -l assignment1.lis -o assignment1.o assignment1.asm

echo "Compile assignment1.c using the gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o manageio.o manageio.c -std=c11

echo "Link the object files using the gcc linker standard 2011"
gcc -m64 -no-pie -o areaofrectangle.out manageio.o assignment1.o -std=c11

echo "Run the program Floating IO:"
./areaofrectangle.out

echo "The script file will terminate"





