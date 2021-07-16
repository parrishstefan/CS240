#!/bin/bash

#Program: Assignment 1: Area of Rectangle
#Author: Stefan Parrish

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble quadratic.asm"
nasm -f elf64 -l quadratic.lis -o quadratic.o quadratic.asm

echo "Compile second_degree.c using the gcc compiler standard 2011"

gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11

echo "Compile isfloat.cpp using the gcc compiler standard 2011"
g++ -c -m64 -Wall -l isfloat.lis -o isfloat.o isfloat.cpp -fno-pie -no-pie

echo "Compile quadlibrary.cpp using the gcc compiler standard 2011"
g++ -c -m64 -Wall -l quadlibrary.lis -o quadlibrary.o quadlibrary.cpp -fno-pie -no-pie

echo "Link the object files using the gcc linker standard 2011"
g++ -m64 -no-pie -o assignment2.out second_degree.o isfloat.o quadlibrary.o quadratic.o -std=c11

echo "Run the program Quadratic Formula:"
./assignment2.out

echo "The script file will terminate"





