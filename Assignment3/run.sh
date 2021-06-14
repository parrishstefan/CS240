#!/bin/bash

#Program: Assignment 3: Sum of an Array
#Author: Stefan Parrish

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm

echo "Assemble fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo "Assemble sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Compile main.c using the gcc compiler standard 2011"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Compile display.cpp using the gcc compiler standard 2011"
g++ -c -m64 -Wall -l display.lis -o display.o display.cpp -fno-pie -no-pie

echo "Link the object files using the gcc linker standard 2011"
g++ -m64 -no-pie -o assignment3.out main.o control.o fill.o display.o sum.o -std=c11

echo "Run the program, Sum of an Array"
./assignment3.out

echo "The script file will terminate"





