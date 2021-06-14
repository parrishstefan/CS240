/*
;********************************************************************************************
; Program name:          Assignment 3 - Sum of an Array                                     *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to input floats into an array and         *
;                        returns the sum of floats in the array.                            *
;                                                                                           *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Stefan Parrish                                                              *
; Email:        parrishstefan@csu.fullerton.edu                                             *    
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-07 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2021 Stefan Parrish                                                         *
; This program is free software: you can redistribute it and/or modify it under the terms   * 
; of the GNU General Public License version 3 as published by the Free Software Foundation. * 
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * 
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: Assignment 3 - Sum of an Array                                            *
;   Programming languages: One module in C, Three modules in X86, One modules in c++        *
;   Files in this program: control.asm, fill.asm, sum.asm, display.cpp, main.c,             *   
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      display.cpp                                                                 *
;    Purpose:   Prints out all floats from the array separated by a single space            *
;                                                                                           *
;********************************************************************************************
*/

#include <stdio.h>

extern "C" void displayArray(double array[], int index);

void displayArray(double array[], int index)
{
    for (int i = 0; i < index; ++i)
    {
        printf("%5.8lf\n", array[i]);
    }
}
