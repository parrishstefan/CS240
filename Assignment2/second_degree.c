// *****************************************************************************************************************************
// Program name: "Quadratic Formula".  This program takes 3 inputs from the user (a,b,c). The program will then decide if the  *
// values are valid float inputs, if they are valid the program will calculate the roots of the function for quadratic formula *
//  Copyright (C) 2021 Stefan Parrish.                                                                                        *
//                                                                                                                            *
// This file is part of the software program "Quadratic Formula".                                                         *
// Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the                    *
// GNU General Public License version 3 as published by the Free Software Foundation.                                          *
// Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied*
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
// A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                             *
// *****************************************************************************************************************************

// ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

// Author information
//  Author name: Stefan Parrish
//  Author email: parrishstefan@fullerton.edu

// Program information
//  Program name: Quadratic Formula
//  Programming languages: Three Modules in C++ and ne modules in C and one module in X86
//  Date program began: 2021-Feb-20
//  Date of last update: 2021-Feb-28
//  Date of reorganization of comments: 2021-Feb-28
//  Files in this program: quadratic.asm, second_degree.c, isfloat.cpp, quadlibrary.cpp
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.

// This file
//   File name: second_degree.c
//   Language: C
//   Max page width: 132 columns
//   Assemble: gcc -c -Wall -m64 -no-pie -o second_degree.o second_degree.c -std=c11
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h> //For C99 compatibility
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>   //For malloc
//At the time of this writing C99 is the newest available standard for C language.  Most modern C compilers conform to the C99
//standard.  The GNU compiler, known as gcc, is C99 compliant.  If both languages, C and X86, are C99 compliant then object code
//files from both compilers may be linked to form a single executable.
//
//The standard prototypes for any functions that may be called later.  This main function calls exactly one function.
extern double quadratic();
//
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("Welcome to Root Calculator\n");
 printf("Programmed by Stefan Parrish, Professional Programmer.\n");
 answer = quadratic();
 printf("The main function received this number %5.3lf and has decided to keep it\n",answer);
 printf("A 0 will be returned to the operating system\n");
 printf("Have a nice day.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
