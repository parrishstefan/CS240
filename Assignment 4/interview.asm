; //*****************************************************************************************************************************
; //Program name: "King of Assembly".  This program demonstrates inputting a string with an embedded white space. This program   *
; //also passed paramaters back and forth between C++ and assembly files which determine the salary of the user.                *
; //Copyright (C) 2021 Stefan Parrish.                                                                                          *
; //                                                                                                                            *
; //This file is part of the software program "King of Assembly".                                                               *
; //King of Assembly is free software: you can redistribute it and/or modify it under the terms of the                          *
; //GNU General Public License version 3 as published by the Free Software Foundation.                                          *
; //King of Assembly is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied      *
; //warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.      *
; //A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                             *
; //*****************************************************************************************************************************


; //=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; //
; //Author information
; //  Author name: Stefan Parrish
; //  Author email: parrishstefan@fullerton.edu
; //
; //Program information
; //  Program name: King of Assembly
; //  Programming languages: One modules in C++ and one module in X86
; //  Date program began: 2021-April-25
; //  Date of last update: 2021-May-11
; //  Date of reorganization of comments: 2021-May-11
; //  Files in this program: main.cpp, interview.asm
; //  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04.
; //
; //Purpose
; //  Takes input from main.cpp for name and requested salary. It then asks a couple more technical questions and which
; //  major interviewee has. It then passes the needed information back to main.cpp
; //
; //This file
; //   File name: interview.asm
; //   Language: assembly


;===== Begin code area ================================================================================================
extern printf
extern scanf
global interview


segment .data

welcome db "Hello %s.  I am Ms Fenster.  The interview will begin now.",10,0
welcome2 db "Wow! $%.2lf  That's a lot of cash.  Who do you think you are, Chris Sawyer (y or n)?",0

yesAnswer db "y",0

;Preset salaries for different majors/people
chrisSawyerSalary dq 1000000.00
compSciSalary dq 88000.88
philosophySalary dq 1200.12

workElectricity db "Alright. Now we will work on your electricity.",10,0
enterOneResistance db "Please enter the resistance of circuit #1 in ohms: ",0
enterTwoResistance db "What is the resistance of circuit #2 in ohms: ",0
answerResistance db "The total resistance is %.5lf ohms.",10,0
questionCS db "Were you a computer science major (y or n)?",0

good_bye db "Thank you.  Please follow the exit signs to the front desk.",10,0

;Format for y/n input in string
one_string_format db "%s",0
;Format for ohms input in float
one_float_format db "%lf",0

segment .bss  ;Reserved for uninitialized data

interview.sawyerAnswer resb 8
interview.compSciAnswer resb 8

segment .text ;Reserved for executing instructions.

interview:

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

mov r15, rdi                     ;r15 is name of user
movsd xmm11, xmm0                ;xmm11 is annual salary requested

;Display a welcome message to the viewer.
mov rax, 0
mov rdi, welcome
mov rsi, r15
call printf


push qword 0
mov rax, 1
mov rdi, welcome2
movsd xmm0, xmm11
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, interview.sawyerAnswer
call scanf
pop rax

lea esi, [interview.sawyerAnswer]
lea edi, [yesAnswer]
mov ecx, 1
rep cmpsb
mov eax, 4
mov ebx, 1
jne NotEqual

;ANSWERS YES
jmp Sawyer

;ANSWERS NO
NotEqual:

push qword 0
mov rax, 0
mov rdi, workElectricity
call printf
pop rax

;User input for ohm resistance
push qword 0
mov rax, 0
mov rdi, enterOneResistance
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm15, [rsp]
pop rax

push qword 0
mov rax, 0
mov rdi, enterTwoResistance
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_float_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax
;End inputs

;Calculate total resistance
movsd xmm13, xmm15              ;xmm13 temp holder

mulsd xmm13, xmm14
addsd xmm15, xmm14
divsd xmm13, xmm15

;Outputs calculated ohm resistance
push qword 0
mov rax, 1
mov rdi, answerResistance
movsd xmm0, xmm13
call printf
pop rax

;Asks if user is a CS major
push qword 0
mov rax, 0
mov rdi, questionCS
call printf
pop rax

push qword 0
mov rax, 0
mov rdi, one_string_format
mov rsi, interview.compSciAnswer
call scanf
pop rax

lea esi, [interview.compSciAnswer]
lea edi, [yesAnswer]
mov ecx, 1
rep cmpsb
mov eax, 4
mov ebx, 1
jne NoCompSci

;Comp Sci Major
movsd xmm10, [compSciSalary]
jmp EndProgram

;Philosophy Major
NoCompSci:
movsd xmm10, [philosophySalary]
jmp EndProgram

;Name is Chris Sawyer
Sawyer:
movsd xmm10, [chrisSawyerSalary]

;============= Prepare to exit from this program ======================================================================
EndProgram:
;Display good-bye message (the next block of instructions)
push qword 0
mov rax, 0
mov rdi, good_bye
call printf
pop rax                        ;Reverse the push near the beginning of this asm function.
pop rax
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
