#!/bin/bash

#Program: Test 1: Cartesian Distance
#Author: Stefan Parrish

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble test1.asm"
nasm -f elf64 -l test1.lis -o test1.o test1.asm

echo "Compile test1.c using the gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o manageio.o manageio.c -std=c11

echo "Link the object files using the gcc linker standard 2011"
gcc -m64 -no-pie -o distancecalc.out manageio.o test1.o -std=c11

echo "Run the program Cartesian Distance:"
./distancecalc.out

echo "The script file will terminate"





