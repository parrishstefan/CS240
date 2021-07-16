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
//   File name: isfloat.cpp
//   Language: C++
//   Max page width: 132 columns
//   Assemble: g++ -c -m64 -Wall -l isfloat.lis -o isfloat.o isfloat.cpp -fno-pie -no-pie

#include <iostream>
#include <string>

extern "C" bool isfloat(char [ ]);
extern "C" double stringtofloat(char []);

bool isfloat(char w[ ])
{   
      //printf("\nISFLOAT: %s\n", w);

    bool result = true;
    bool onepoint = false;
    int start = 0;
    if (w[0] == '-' || w[0] == '+') start = 1;
    unsigned long int k = start;
    while (!(w[k] == '\0') && result )
    {    if (w[k] == '.' && !onepoint) 
               onepoint = true;
         else
               result = result && isdigit(w[k]) ; 
         k++;
     }
     //printf("Returning from isFloat\n");
     //std::cout << result << onepoint;
     return result && onepoint;
}

double stringtofloat(char w[]) {
      double newFloat;
      //printf("GOT HERE%s\n", w);
     // sscanf(w,"%lf", &newFloat);

     newFloat = atof(w);

      //printf("New Float: %lf \n", newFloat);
      //printf("GOT HERE2\n");
      return newFloat;
}