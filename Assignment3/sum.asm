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
;    Name:      sum.asm                                                                     *
;    Purpose:   Adds up all float values in the array and returns the sum to control        *
;                                                                                           *
;********************************************************************************************

global sum                             ; Makes function callable from other linked files.
extern printf

section .data  
    giveZero dd 0

section .bss

section .text

sum:

; Back up all registers to stack and set stack pointer to base pointer
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
pushf

push qword -1                           ; Extra push onto stack to make even # of pushes.

mov r15, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r13, 0                              ; Sum register to add elements of array to.
mov r12, 0                              ; Counter to to iterate through array.
movsd xmm11, [giveZero]

;-----------------------------------START LOOP----------------------------------------------
begin_loop:

; Compares the counter (r12) to the number of elements in the array (r14).
cmp r12, r14                        
jge outofloop

;--------------------------------COPY INTO ARRAY--------------------------------------------
; Adds element of array at index of r12 to the Sum of register r13.
addsd xmm11, [r15 + 8 * r12]            
inc r12                                 ; Increments counter r12 by 1.

; Restarts loop
jmp begin_loop          

;----------------------------------END OF LOOP----------------------------------------------
outofloop:

movsd xmm0, xmm11

; Restores all backed up registers to their original state.
pop rax                                ; Remove extra push of -1 from stack.
popf                                                       
pop rbx                                                     
pop r15                                                     
pop r14                                                      
pop r13                                                      
pop r12                                                      
pop r11                                                     
pop r10                                                     
pop r9                                                      
pop r8                                                      
pop rcx                                                     
pop rdx                                                     
pop rsi                                                     
pop rdi                                                     
pop rbp

ret