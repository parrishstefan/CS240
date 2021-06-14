// Author information
//  Author name: Stefan Parrish
//  Author email: parrishstefan@fullerton.edu
//  ENROLLED IN SECTION 07
//  TOOK TEST FROM SECTION 1&5

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