//*****************************************************************************************************************************
//Program name: "Perimeter of Rectangle".  This program demonstrates the input of a width and length of sides to a rectangle. *
//Then calculation with addition and division to calculate the perimter of the rectangle as well as the average length of all *
//sides of the rectangle.  Copyright (C) 2021 Stefan Parrish.                                                                 *
//                                                                                                                            *
//This file is part of the software program "Perimeter of Rectangle".                                                         *
//Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the                    *
//GNU General Public License version 3 as published by the Free Software Foundation.                                          *
//Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied*
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                             *
//*****************************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Stefan Parrish
//  Author email: parrishstefan@fullerton.edu
//
//Program information
//  Program name: Perimeter of Rectangle
//  Programming languages: One modules in C and one module in X86
//  Date program began: 2021-Feb-10
//  Date of last update: 2021-Feb-10
//  Date of reorganization of comments: 2021-Feb-10
//  Files in this program: manageio.c, assignment1.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
//
//Purpose
//  Show how to calculate float values through addition and division with input and output floating point (64-bit) numbers.
//
//This file
//   File name: manageio.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -std=c11 -no-pie -o current-time.o current-time.c
//   Link: gcc -m64 -no-pie -o current.out -std=c11 current-time.o date_and_time.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
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
extern double floatio();
//
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("The main function manage-floats.c has begun\n");
 printf("The function floatio will now be called\n");
 answer = floatio();
 printf("The main function received this number %4.1lf and has decided to keep it\n",answer);
 printf("A 0 will be returned to the operating system\n");
 printf("Have a nice day.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
