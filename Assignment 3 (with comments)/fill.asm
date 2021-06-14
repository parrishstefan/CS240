;********************************************************************************************
; Program name:          Sum of Integers - Array                                            *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to input integers into an array and       *
;                        returns the sum of integers in the array.                          *
;                                                                                           *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         Bilal El-haghassan                                                          *
; Email:        bilalelhaghassan@csu.fullerton.edu                                          *    
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-05 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2020 Bilal El-haghassan                                                     *
; This program is free software: you can redistribute it and/or modify it under the terms   * 
; of the GNU General Public License version 3 as published by the Free Software Foundation. * 
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * 
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: Sum of Integers - Array                                                   *
;   Programming languages: One module in C, Four modules in X86, Two modules in c++         *
;   Files in this program: manager.asm, input_array.asm, sum.asm, atol.asm, main.c,         *   
;   					   validate_decimal_digits.cpp, display_array.cpp                   *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      input_array.asm                                                             *
;    Purpose:   To accept a users input of integers and save it into an array then send     *
;               the total number of elements inputed into the array back to manager.        *
;                                                                                           *
;********************************************************************************************

extern printf
extern scanf

global fill                       ; Makes function callable from other linked files.

section .data
    inputDbl       db "%lf", 0
    outputDbl      db "%lf", 10, 0
    outputArray    db "[%d, %d]: %lf", 10, 0
    outputNum      db "Number of elements: %d", 10, 0

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

;{ Print each number as it is entered.
push qword 0
mov rax, 1
mov rdi, outputDbl  
movsd xmm0, xmm11
call printf
pop rax
;}

;--------------------------------COPY INTO ARRAY--------------------------------------------
movsd [r15 + 8 * r13], xmm11            ; Copy user input into array at index r13.

;{ Print each element afer it is entered in the array.
push qword 0
movsd xmm10, [r15 + 8 * r13]
mov rax, 1
mov rdi, outputDbl  
movsd xmm0, xmm10
call printf
pop rax
;}

inc r13                                 ; Increment array index.

;-----------------------------ARRAY CAPACITY TEST-------------------------------------------
; Test to see if max array capacity has been reached.
cmp r13, r14
jne begin_loop                          ; Loop until R13=R14.

;---------------------------------END OF LOOP-----------------------------------------------
end_loop:

;{ Print number of elements in the array.
push qword 0
mov rax, 1
mov rdi, outputNum
mov rsi, r13
call printf
pop rax
;}

;{ Print all the elements in the array.
mov r9, 0

print_loop:

cmp r9, r13
je exit

movsd xmm10, [r15 + 8 * r9]

push r9
mov rax, 3
mov rdi, outputArray
mov rsi, r9
mov rdx, r13
movsd xmm0, xmm10
call printf
pop r9

inc r9
jmp print_loop
;}

;------------------------------------EXIT---------------------------------------------------
exit:

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
