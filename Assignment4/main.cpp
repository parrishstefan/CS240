//*****************************************************************************************************************************
//Program name: "King of Assembly".  This program demonstrates inputting a string with an embedded white space. This program   *
//also passed paramaters back and forth between C++ and assembly files which determine the salary of the user.                *
//Copyright (C) 2021 Stefan Parrish.                                                                                          *
//                                                                                                                            *
//This file is part of the software program "King of Assembly".                                                               *
//King of Assembly is free software: you can redistribute it and/or modify it under the terms of the                          *
//GNU General Public License version 3 as published by the Free Software Foundation.                                          *
//King of Assembly is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied      *
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
//  Program name: King of Assembly
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2021-April-25
//  Date of last update: 2021-May-11
//  Date of reorganization of comments: 2021-May-11
//  Files in this program: main.cpp, interview.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
//
//Purpose
//  Takes name and requested salary input from user and passed it to interview.asm. After recieveing more information from interivew.asm,
//  it calculates the actual salary for the interviewee.
//
//This file
//   File name: main.cpp
//   Language: C++

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h> //For C99 compatibility
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>   //For malloc
#include <string.h>
#include <iostream>
#include <iomanip>

using namespace std;

extern "C" double interview(const char* userName, double salary);

int main(int argc, char* argv[]) {
    //Salary given to applicant after interview
    double actualSalary = 0.0;
    //Salary requested by interviewee
    double requestedSalary = 0.0;
    //First/Last Name of interviewee
    string userName;

    cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n";

    //Gets input from interviewee for first and last name with whitespace
    cout << "Please enter your first and last names and press enter: ";
    getline(cin, userName);
    
    cout << "Thank you " << userName << ".  Our records show that you applied for employment here with our agency a week ago.\n";

    //Gets input from interviewee for salary as double
    cout << "Please enter your expected annual salary when employed at Paramount: ";
    cin  >> requestedSalary;

    cout << "Your interview with Ms Linda Fenster, Personnel Manager, will begin shortly.\n";

    actualSalary = interview(userName.c_str(), requestedSalary);

    if(actualSalary > 88000.88) {
        cout << "Hello Mr Sawyer. I am the receptionist.\n";
        cout << "This envelope has your job offer starting at 1 million annual.\n";
        cout << "Please start any time you like.\n";
        cout << "In the middle time our CTO wishes to have dinner with you.\n";
        cout << "Have a very nice evening Mr Sawyer.\n";

    } else if(actualSalary == 88000.88) {
        cout << "Hello " << userName << " I am the receptionist.\n";
        printf("This envelope contains your job offer with starting salary $%.2lf\n", actualSalary);
        cout << "Please check back on Monday morning at 8am.\n";
        cout << "Bye\n";
    }else {
        cout << "Hello " << userName << " I am the receptionist.\n";
        printf("We have an opening for you in the company cafeteria for $%.2lf annually.\n", actualSalary);
        cout << "Take your time to let us know your decision.\n";
        cout << "Bye\n";
    }
    
    
    return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
