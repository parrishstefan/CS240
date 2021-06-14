//Stefan Parrish
//CPSC240-7 Test 1

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
 printf("The main function manageio.c has begun\n");
 printf("The function floatio will now be called\n");
 answer = floatio();
 printf("The Euclid module received this number %4.6lf and has decided to keep it\n",answer);
 printf("A 0 will be returned to the operating system. Stay safe and well.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
