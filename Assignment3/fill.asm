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
;    Name:      fill.asm                                                                   *
;    Purpose:   Takes float value inputs from user and puts them into an array and returns  *
;               the total number of inputs to control                                       *
;                                                                                           *
;********************************************************************************************

extern printf
extern scanf

global fill                       ; Makes function callable from other linked files.

section .data

    inputDbl db "%lf", 0
    instructions db "Please enter floating point numbers separated by ws",10,0
    instructions2 db "When finished press enter followed by Ctrl+D.",10,0
    
section .bss

section .text

fill:

; Back up all registers and set stack pointer to base pointer
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

push qword -1                           ; Extra push to create even number of pushes

;-----------------------------INITIALIZE PARAMETERS-----------------------------------------
mov r15, rdi                      ; Address of array saved to r15.
mov r14, rsi                      ; Max number of elements allowed in array.
mov r13, 0                        ; Counter to iterate through array.

;-----------------------------OUTPUT PROMPT-------------------------------------------------
push qword 0
mov rax, 0                    
mov rdi, instructions
call printf                             ; Print out intructionS prompt.
pop rax

push qword 0
mov rax, 0                    
mov rdi, instructions2
call printf                             ; Print out intructionS prompt.
pop rax

;---------------------------------START OF LOOP---------------------------------------------
begin_loop:

; Scanf function called to take user input.
push qword 0
mov rax, 0
mov rdi, inputDbl  
mov rsi, rsp                            ; Stack pointer points to where scanf outputs
call scanf
movsd xmm11, [rsp]
pop r8

; Test if Control + D is entered to finish inputting into array.
cdqe
cmp rax, -1                          
je end_loop                             ; Exit loop if control + D is pressed.

;--------------------------------COPY INTO ARRAY--------------------------------------------
movsd [r15 + 8 * r13], xmm11            ; Copy user input into array at index r13.

inc r13                                 ; Increment array index.

;-----------------------------ARRAY CAPACITY TEST-------------------------------------------
; Test to see if max array capacity has been reached.
cmp r13, r14
jne begin_loop                          ; Loop until R13=R14.

;---------------------------------END OF LOOP-----------------------------------------------
end_loop:

; Restore all backed up registers to their original state.
pop rax                                 ; Remove extra push of -1 from stack.
mov rax, r13                            ; Copy # of elements in r13 to rax.

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
