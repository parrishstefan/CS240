#!/bin/bash

#Program: Assignment 4: King of Assembly
#Author: Stefan Parrish

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble interview.asm"
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo "Compile main.cpp using the g++ compiler"
g++ -c -m64 -Wall -std=c++17 -fno-pie -no-pie -o main.o main.cpp

echo "Link the object files using the g++ linker standard 2011"
g++ -m64 -no-pie -o assignment4.out main.o interview.o -std=c11

echo "Run the program Assignment 4: King of Assembly"
./assignment4.out

echo "The script file will terminate"





