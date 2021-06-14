
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
;   validate_decimal_digits.cpp, display_array.cpp                                          *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      manager.asm                                                                 *
;    Purpose:   To manage all the files in the program and call to functions input_array,   *
;               sum and display_array as needed.                                            *
;                                                                                           *
;********************************************************************************************

extern printf
extern scanf
extern fill
extern displayArray
extern sum

array_size equ 100                        ; Set capacity limit of array.

global control                          ; Make function callable from other linked files.

section .data
    instructions db "Welcome to HSAS.  The accuracy and reliability of this program is guaranteed by Stefan Parrish.", 10, 0

    numElements db "You have entered %d numbers.", 10, 0
    sumFormat   db "The sum of the %d numbers in this array is %5.8lf.", 10, 0
    sumPrompt   db "The control module will now return the sum to the caller module.", 10, 0
    floatFormat db "%ld", 0 
    outputDbl   db "%lf", 10, 0

section .bss
    floatArray: resq 100                  ; Reserve space for uninitialized array based on array_size above.

section .text

control:

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
pushf

push qword 0                            ; Extra push to create even number of pushes

;-------------------------------INSTRUCTION PROMPT------------------------------------------

push qword 0
mov rax, 0                    
mov rdi, instructions
call printf                             ; Print out intructionS prompt.
pop rax

;---------------------------CALL FUNCTION INPUT_ARRAY---------------------------------------

mov rdi, floatArray                     ; Pass array into rdi register.
mov rsi, array_size                     ; Pass the max array size into rsi register.
call fill                               ; Call funtion to input array.
mov r14, rax                            ; Put number of elements in array in r14.

;-------------------------CONFIRM INPUTTED VALUES--------------------------------

;{ Print number of elements returned.
push qword 0
mov rax, 1
mov rdi, numElements
mov rsi, r14
call printf
pop rax
;}

mov r15, floatArray                     ; Put array into r15.
mov r13, 0                              ; Counter to iterate through array.

;{ Print each element afer it is entered in the array.
; push qword 0
; movsd xmm10, [r15 + 8 * r13]
; mov rax, 1
; mov rdi, outputDbl  
; movsd xmm0, xmm10
; call printf
; pop rax
;}

;{ Print all the elements in the array.
; mov r9, 0

; print_loop:

; cmp r9, r14
; je exit

; movsd xmm10, [r15 + 8 * r9]

; push r9
; mov rax, 1
; mov rdi, outputDbl
; movsd xmm0, xmm10
; call printf
; pop r9

; inc r9
; jmp print_loop
;}

;----------------------------DISPLAY ELEMENTS OF ARRAY--------------------------------------
; Calls display_array that prints out each integer in the array seperated by 1 space.

push qword 0
mov qword rdi, floatArray               ; Pass the array as first parameter.
mov qword rsi, r14                      ; Pass # of elements in the array stored in r14.
call displayArray                       ; Call display_array function.
pop rax

;-----------------------------------CALLS SUM-----------------------------------------------
; Calls function sum to return the sum of integers in the array

mov qword rdi, floatArray               ; Pass the array as first parameter.  
mov qword rsi, r14                      ; Pass # of elements in the array stored in r14.
mov qword rax, 0
call sum                                ; Function sum to add all the integers in array. 
movsd xmm11, xmm0

;--------------------------PRINTS OUT TOTAL # OF INTEGERS AND SUM--------------------------- 

push qword 0
mov qword rdi, sumFormat
mov qword rdx, r13                      ; Pass the sum of integers in the array to print.
mov qword rax, 2
movsd xmm0, xmm11
call printf                             ; Print out # of elements & sum
pop rax

;---------------------------------PRINTS OUT SUMPROMPT-------------------------------------- 

mov rax, 0                    
mov rdi, sumPrompt
call printf                             ; Print out that sum will be returned to main.

;---------------------------------END OF FILE-----------------------------------------------
exit:

; Restore all registers to their original state.
pop rax                                 ; Remove extra push from stack.
movsd xmm0, xmm11                       ; Return sum.
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
