; // Author information
; //  Author name: Stefan Parrish
; //  Author email: parrishstefan@fullerton.edu
; //  ENROLLED IN SECTION 07
; //  TOOK TEST FROM SECTION 1&5

initial_value equ 0
initial_division equ 1

extern printf
global harmonic                             ; Makes function callable from other linked files.

section .data  
outputMean   db "The harmonic mean of these numbers is %lf.",10,0
;returnDriver db "The harmonic mean will be returned to the driver.",10,0

section .bss

section .text

harmonic:

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
mov r11, initial_division
cvtsi2sd xmm11, r11
movsd xmm10, xmm11

mov r10, initial_value
cvtsi2sd xmm9, r10

;-----------------------------------START LOOP----------------------------------------------
begin_loop:

; Compares the counter (r12) to the number of elements in the array (r14).
cmp r12, r14                        
jge outofloop

;--------------------------------CALCULATES HARMONIC MEAN-------------------------------------------

movsd xmm11, xmm10
divsd xmm11, [r15 + 8 * r12]
addsd xmm15, xmm11

inc r12

; Restarts loop
jmp begin_loop          

;----------------------------------END OF LOOP----------------------------------------------
outofloop:

cvtsi2sd xmm14, r14
divsd xmm14, xmm15

push qword 0
mov rax, 1
mov rdi, outputMean
movsd xmm0, xmm14
call printf
pop rax


movsd xmm0, xmm14

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