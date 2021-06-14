/*
;********************************************************************************************
; Program name:          Sum of Integers - Array                                            *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to input integers into an array and       *
;                        returns the sum of integers in the array.                          *
;                                                                                           *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Bilal El-haghassan                                                          *
; Email:        bilalelhaghassan@csu.fullerton.edu                                          *    
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2020 Bilal El-haghassan                                                     *
; This program is free software: you can redistribute it and/or modify it under the terms   * 
; of the GNU General Public License version 3 as published by the Free Software Foundation. * 
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * 
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: Sum of Integers - Array                                                   *
;   Programming languages: One module in C, Four modules in X86, Two modules in c++         *
;   Files in this program: manager.asm, input_array.asm, sum.asm, atol.asm, main.c,         *   
;   					   validate_decimal_digits.cpp, display_array.cpp                   *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      main.c                                                            			*
;    Purpose:   Prints the welcome message and calls on manager to produce value. Then      *
;				prints out value and outgoing message.       							    *
;                                                                                           *
;********************************************************************************************
*/

#include <stdio.h>
#include <stdint.h>

extern double control();

int main()
{double sumArray;
	printf("\nWelcome to High Speed Array Summation by Stefan Parrish.\n");
	printf("Software Licensed by GNU GPL 3.0\n");
        printf("Version 1.0 released on January 28, 2021.\n");

	sumArray = control();

	printf("The main has received this sum, %lf, and will keep it\n", sumArray);
	printf("Thank you for using High Speed Array Software.\n");
	printf("For system support contact Stefan Parrish at parrishstefan@csu.fullerton.edu\n");
	printf("A zero will be returned to the operating system.\n");
	return 0;
}
