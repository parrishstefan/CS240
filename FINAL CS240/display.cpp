// Author information
//  Author name: Stefan Parrish
//  Author email: parrishstefan@fullerton.edu
//  ENROLLED IN SECTION 07
//  TOOK TEST FROM SECTION 1&5

#include <stdio.h>

extern "C" void displayArray(double array[], int index);

void displayArray(double array[], int index)
{
    for (int i = 0; i < index; ++i)
    {
        printf("%5.8lf\n", array[i]);
    }
}
