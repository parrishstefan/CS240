#include <stdio.h>

extern "C" void displayArray(double array[], int index);

void displayArray(double array[], int index)
{
    for (int i = 0; i < index; ++i)
    {
        printf("[%d] = %lf\n", i, array[i]);
    }
}
