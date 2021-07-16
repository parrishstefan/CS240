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
//   File name: quadlibrary.cpp
//   Language: C++
//   Max page width: 132 columns
//   Assemble: g++ -c -m64 -Wall -l quadlibrary.lis -o quadlibrary.o quadlibrary.cpp -fno-pie -no-pie

#include <iomanip>
#include <iostream>
#include <math.h>

extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

extern "C" double quadraticCalc(double a, double b, double c);

double quadraticCalc(double a, double b, double c) {
    double numRoots;
    double calculationPos = 0.0;
    double calculationNeg = 0.0;

    //Calculates if there will be 1, 2, or no roots
    numRoots = (b*b)-(4*a*c);

    //Does calculates using quadratic formula
    if(numRoots > 0) {
        calculationPos = (-b + sqrt(numRoots))/(2*a);
        calculationNeg = (-b - sqrt(numRoots))/(2*a);
    } else if(numRoots == 0) {
        calculationPos = -b/(2*a);
    } else {
        calculationPos = 0.0;
    }   

    if(numRoots > 0) {
        show_two_root(calculationPos, calculationNeg);
    } else if(numRoots < 0) {
        show_no_root();
    } else {
        show_one_root(calculationPos);
    }

    //Returns one of the roots
    //If there are no roots, returns 0
    return calculationPos;

}

void show_no_root() {
    printf("There are no roots.\n");
}

void show_one_root(double root) {
    printf("There one root is %5.4lf \n", root);
}

void show_two_root(double root1, double root2) {
    printf("The roots are %5.4lf and %5.4lf \n", root1, root2);
}