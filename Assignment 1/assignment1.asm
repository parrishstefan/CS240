;*****************************************************************************************************************************
;Program name: "Perimeter of Rectangle".  This program demonstrates the input of a width and length of sides to a rectangle. *
;Then calculation with addition and division to calculate the perimter of the rectangle as well as the average length of all *
;sides of the rectangle.  Copyright (C) 2021 Stefan Parrish.                                                                 *
;                                                                                                                            *
;This file is part of the software program "Perimeter of Rectangle".                                                         *
;Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the                    *
;GNU General Public License version 3 as published by the Free Software Foundation.                                          *
;Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied*
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                             *
;*****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Stefan Parrish
;  Author email: parrishstefan@fullerton.edu
;
;Program information
;  Program name: Perimeter of Retangle
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2021-Feb-2
;  Date of last update: 2021-Feb-10
;  Date of reorganization of comments: 2021-Feb-10
;  Files in this program: manageio.c, assignment1.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
;
;This file
;   File name: assignment1.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l assignment1.lis -o assignment1.o assignment1.asm


;===== Begin code area ================================================================================================
extern printf
extern scanf
global floatio


segment .data
welcome db "Welcome to an friendly assembly program by Stefan Parrish.",10,0
welcome2 db "This program will compute the perimeter and the average side length of a rectangle.",10,0

;Prompt for user to input height and width
inputheightprompt db "Enter the height: ",0
inputwidthprompt db "Enter a width: ",0

;Output for calculations of perimeter and average length of sides
perimeteroutput db "The perimeter is %5.3lf",10,0
averagesideoutput db "The length of the average side is %5.3lf",10,0

good_bye db "I hope you enjoyed your rectangle",10,0
good_bye2 db "The assembly program will send the perimeter to the main function.",10,0

;Format for inputs for width/height given by user
one_float_format db "%lf",0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

floatio:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0


;Display a welcome message to the viewer.
mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, welcome
call printf
mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, welcome2
call printf


;============= Begin section to input two float numbers using one call to scanf =======================================
;Display a prompt message asking for inputs

push qword 0
;Display a prompt message asking for input for height of rectangle
mov rax, 0
mov rdi, inputheightprompt
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

push qword 0
;Display a prompt message asking for input for width of rectangle
mov rax, 0
mov rdi, inputwidthprompt
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

;Calculates perimeter of rectangle
movsd xmm12, xmm10
addsd xmm12, xmm11
addsd xmm12, xmm12
push qword 99
mov rax, 1
mov rdi, perimeteroutput
movsd xmm0, xmm12
call printf
pop rax

;Calculates average length of sides of rectangle
mov r15, 4
;converts r->xmm to be able to divide by constant
cvtsi2sd xmm13, r15
movsd xmm14, xmm12
divsd xmm14, xmm13
push qword 99
mov rax, 1                     ;printf will need access to thhis many
mov rdi, averagesideoutput     
movsd xmm0, xmm14
call printf
pop rax

;============= End of section to input two float numbers ==============================================================


;============= Prepare to exit from this program ======================================================================

;Display good-bye message (the next block of instructions)
mov rax, 0
mov rdi, good_bye
call printf
mov rax, 0
mov rdi, good_bye2
call printf

pop rax                        ;Reverse the push near the beginning of this asm function.

movsd xmm0, xmm12

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
