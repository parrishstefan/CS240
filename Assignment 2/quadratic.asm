; *****************************************************************************************************************************
; Program name: "Quadratic Formula".  This program takes 3 inputs from the user (a,b,c). The program will then decide if the  *
; values are valid float inputs, if they are valid the program will calculate the roots of the function for quadratic formula *
;  Copyright (C) 2021 Stefan Parrish.                                                                                        *
;                                                                                                                            *
; This file is part of the software program "Quadratic Formula".                                                         *
; Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the                    *
; GNU General Public License version 3 as published by the Free Software Foundation.                                          *
; Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied*
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
; A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                             *
; *****************************************************************************************************************************

; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

; Author information
;  Author name: Stefan Parrish
;  Author email: parrishstefan@fullerton.edu

; Program information
;  Program name: Quadratic Formula
;  Programming languages: Three Modules in C++ and ne modules in C and one module in X86
;  Date program began: 2021-Feb-20
;  Date of last update: 2021-Feb-28
;  Date of reorganization of comments: 2021-Feb-28
;  Files in this program: quadratic.asm, second_degree.c, isfloat.cpp, quadlibrary.cpp
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.

; This file
;   File name: quadratic.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l assignment1.lis -o assignment1.o assignment1.asm


;===== Begin code area ================================================================================================
extern printf
extern scanf
global quadratic

;isfloat.cpp
extern isfloat
extern stringtofloat

extern quadraticCalc

segment .data

welcome db "This program will find the roots of any quadratic equation.",10,0

;Prompt for user to input a, b, c for calculations
inputfloatingpoints db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character. ",10,0

;End program output
good_bye db "One of these roots will be returned to the caller function.",10,0

;User inputted incorrectly formatted floats
inputwrong db "This is not a quadratic equation. You may run this program again.",10,0
;User inputted correct formatted floats
inputright db "Thank you. The equation is %sx^2 + %sx + %s = 0.0",10,0

;Format for three strings given by user (needs to be in float format)
three_string_format db "%s%s%s",0

;Testing purposes only
; testerFloat db "TEST ROOT: %5.3lf",10,0
; testerInt db "TEST Int: %d",10,0
; testerThreeInt db "TEST 3 Int: %d %d %d",10,0
; testerThreeFloat db "TEST 3 FLOAT: %lf %lf %lf",10,0

segment .bss  ;Reserved for uninitialized data

;Value holders for inputs by user
quadratic.stringa resb 32
quadratic.stringb resb 32
quadratic.stringc resb 32

segment .text ;Reserved for executing instructions.

quadratic:

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
mov rax, 0                    
mov rdi, welcome
call printf

;============= Begin section to input two float numbers using one call to scanf =======================================
;Display a prompt message asking for inputs

;Display a prompt message asking for input for three floating point coefficients for quadratic equation
push qword 0
mov rax, 0
mov rdi, inputfloatingpoints
call printf
pop rax

;Inputs values into three variables for later use
push qword 99
push qword -1
push qword -2
mov rax, 0
mov rdi, three_string_format
mov rsi, quadratic.stringa
mov rdx, quadratic.stringb
mov rcx, quadratic.stringc
call scanf
pop rax
pop rax
pop rax

; Outputs three strings
; mov rax, 1
; mov rdi, three_string_format
; mov rsi, quadratic.stringa
; mov rdx, quadratic.stringb
; mov rcx, quadratic.stringc
; call printf
; pop rax

;Checks if the input values from user are in valid float format x.x
mov rax, 0
mov rdi, quadratic.stringa
call isfloat
mov r14, rax

; mov rax, 0
; mov rdi, testerInt
; mov rsi, r14
; call printf

mov rax, 0
mov rdi, quadratic.stringb
call isfloat
mov r13, rax

; mov rax, 0
; mov rdi, testerInt
; mov rsi, r13
; call printf

mov rax, 0
mov rdi, quadratic.stringc
call isfloat
mov r12, rax

; mov rax, 0
; mov rdi, testerInt
; mov rsi, r12
; call printf

;Outputs three Ints for booleans
; push qword 99
; mov rax, 0
; mov rdi, testerThreeInt
; mov rsi, r14
; mov rdx, r13
; mov rcx, r12
; call printf
; pop rax

add r13, r14
add r13, r12
mov r10, 2

;r13 >  2 -> True
;Else false
cmp r10, r13
jl FloatTrue
jmp FloatFalse

FloatTrue:
;If the values are floats then output to user correct inputs
push qword 99
mov rax, 1
mov rdi, inputright
mov rsi, quadratic.stringa
mov rdx, quadratic.stringb
mov rcx, quadratic.stringc
call printf
pop rax
jmp ConvertToFloat

FloatFalse:
;If the values are NOT floats then output to user incorrect inputs and end program
mov rax, 0
mov rdi, inputwrong
call printf
pop rax
jmp GoodBye

ConvertToFloat:
;Convets input by user(string) to float
mov rax, 0
mov rdi, quadratic.stringa
call stringtofloat
movq xmm13, rax

mov rax, 0
mov rdi, quadratic.stringb
call stringtofloat
movq xmm12, rax

mov rax, 0
mov rdi, quadratic.stringc
call stringtofloat
movq xmm11, rax

; push qword 99
; mov rax, 3
; mov rdi, testerThreeFloat
; movsd xmm0, xmm13
; movsd xmm1, xmm12
; movsd xmm2, xmm11
; call printf
; pop rax


ShowRoot:
;Calculates the roots of the given variables in quadlibrary.cpp
push qword -1
push qword -2
push qword -3
mov rax, 0 
movsd xmm0, xmm13
movsd xmm1, xmm12
movsd xmm2, xmm11
call quadraticCalc
movsd xmm10, xmm0
pop rax
pop rax 
pop rax

; push qword 99
; mov rax, 1
; mov rdi, testerFloat
; movsd xmm0, xmm10
; call printf
; pop rax

;============= End of section to input two float numbers ==============================================================


;============= Prepare to exit from this program ======================================================================

;Display good-bye message (the next block of instructions)
GoodBye:
mov rax, 0
mov rdi, good_bye
call printf
pop rax                        ;Reverse the push near the beginning of this asm function.

movsd xmm0, xmm10

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
