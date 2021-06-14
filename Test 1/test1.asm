;Stefan Parrish
;CPSC240-7 Test 1


;===== Begin code area ================================================================================================
extern printf
extern scanf
global floatio


segment .data
welcome db "Welcome to the Euclidean Distance Finder Programmed by Stefan Parrish.",10,0

;Prompt user for coordinates
inputfirstprompt db "Please enter the coordinates of the first point separated by enter: ",0
inputsecondprompt db "Please enter the coordinates of the second point separated by enter: ",0

;Output for calculations of distance
distanceoutput db "The distance between those two points is %4.6lf math units.",10,0

good_bye db "The distance module will not return that number to the caller module.",10,0

two_float_format db "%lf %lf",0

;TESTING
;output_one_float db "The two numbers are %5.3lf.",10,0
;output_two_float db "The two numbers are %5.3lf and %5.3lf.",10,0

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


;============= Begin section to input two float numbers using one call to scanf =======================================
;Display a prompt message asking for inputs

push qword 99
mov rax, 0
mov rdi, inputfirstprompt
call printf
pop rax

push qword 99 ;Get on boundary
;Create space for 2 float numbers
push qword -1
push qword -2
mov rax, 0
mov rdi, two_float_format      ;"%lf%lf"
mov rsi, rsp                   ;rsi points to first quadword on the stack
mov rdx, rsp
add rdx, 8                     ;rdx points to second quadword on the stack
call scanf

movsd xmm11, [rsp]
movsd xmm12, [rsp+8]
pop rax                        ;Reverse the previous "push qword -2"
pop rax                        ;Reverse the previous "push qword -1"
pop rax                        ;Reverse the previous "push qword 99"

;Display first coordinate input
;push qword 99                  ;Get on the boundary
;mov rax, 2
;mov rdi, output_two_float
;movsd xmm0, xmm11
;movsd xmm1, xmm12
;call printf
;pop rax                        ;Reverse previous "push qword 99"

push qword 99
mov rax, 0
mov rdi, inputsecondprompt
call printf
pop rax

push qword 99 ;Get on boundary
;Create space for 2 float numbers
push qword -1
push qword -2
mov rax, 0
mov rdi, two_float_format      ;"%lf%lf"
mov rsi, rsp                   ;rsi points to first quadword on the stack
mov rdx, rsp
add rdx, 8                     ;rdx points to second quadword on the stack
call scanf

movsd xmm13, [rsp]
movsd xmm14, [rsp+8]
pop rax                        ;Reverse the previous "push qword -2"
pop rax                        ;Reverse the previous "push qword -1"
pop rax                        ;Reverse the previous "push qword 99"

;Display second coordinate input
;push qword 99                  ;Get on the boundary
;mov rax, 2
;mov rdi, output_two_float
;movsd xmm0, xmm13
;movsd xmm1, xmm14
;call printf
;pop rax                        ;Reverse previous "push qword 99"

;Calculate squares/addition

;xmm3 holds value for x1-x2
movsd xmm3, xmm11
subsd xmm3, xmm13

;xmm4 holds value for y1-y2
movsd xmm4, xmm12
subsd xmm4, xmm14

;Display subtraction of (x1-x2) and (y1-y2)
;push qword 99                  ;Get on the boundary
;mov rax, 2
;mov rdi, output_two_float
;movsd xmm0, xmm3
;movsd xmm1, xmm4
;call printf
;pop rax

;Calculates squared of each
;xmm3 holds value for (x1-x2)^2
;xmm4 holds value for (y1-y2)^2
mulsd xmm3, xmm3
mulsd xmm4, xmm4

;Display square of (x1-x2)^2 and (y1-y2)^2
;push qword 99                  ;Get on the boundary
;mov rax, 2
;mov rdi, output_two_float
;movsd xmm0, xmm3
;movsd xmm1, xmm4
;call printf
;pop rax

;xmm3 holds value for (x1-x2)^2 + (y1-y2)^2
addsd xmm3, xmm4

;xmm2 holds value for cartesian distance
sqrtsd xmm2, xmm3
;Moves xmm2 to xmm12
movsd xmm12, xmm2

;Displays (x1-x2)^2 + (y1-y2)^2
;Displays Cartesian Distance
;push qword 99                  ;Get on the boundary
;mov rax, 2
;mov rdi, output_two_float
;movsd xmm0, xmm3
;call printf
;pop rax

push qword 99
mov rax, 1
mov rdi, distanceoutput
movsd xmm0, xmm12
call printf
pop rax


;============= Prepare to exit from this program ======================================================================

;Display good-bye message (the next block of instructions)
mov rax, 0
mov rdi, good_bye
call printf

pop rax                        ;Reverse the push near the beginning of this asm function.

movsd xmm0, xmm12              ;Returns the distance to the caller.

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
