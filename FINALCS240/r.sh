#!/bin/bash

#Program: FINAL
#Author information
#Author name: Stefan Parrish
#Author email: parrishstefan@fullerton.edu
#ENROLLED IN SECTION 07
#TOOK TEST FROM SECTION 1&5

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble control.asm"
nasm -f elf64 -l control.lis -o control.o control.asm

echo "Assemble fill.asm"
nasm -f elf64 -l fill.lis -o fill.o fill.asm

echo "Assemble harmonic.asm"
nasm -f elf64 -l harmonic.lis -o harmonic.o harmonic.asm

echo "Compile isfloat.cpp using the gcc compiler standard 2011"
g++ -c -m64 -Wall -l isfloat.lis -o isfloat.o isfloat.cpp -fno-pie -no-pie

echo "Compile main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c17

echo "Compile display.cpp using the gcc compiler standard 2011"
g++ -c -m64 -Wall -l display.lis -o display.o display.cpp -fno-pie -no-pie

echo "Link the object files using the g++ linker standard 2011"
g++ -m64 -no-pie -o final.out main.o control.o fill.o isfloat.o display.o harmonic.o -std=c11

echo "Run the program"
./final.out

echo "The script file will terminate"





