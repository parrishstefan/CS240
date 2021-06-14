; // Author information
; //  Author name: Stefan Parrish
; //  Author email: parrishstefan@fullerton.edu
; //  ENROLLED IN SECTION 07
; //  TOOK TEST FROM SECTION 1&5

extern printf
extern scanf
extern fill
extern displayArray
extern harmonic

array_size equ 100                        ; Set capacity limit of array.

global control                          ; Make function callable from other linked files.

section .data
    instructions db "Enter float numbers separated by white space.  Invalid inputs will be omitted.", 10, 0
    instructions2 db "Enter control+D to terminate.",10,0

    enteredPrompt db "Thank you.  You entered",10,0

    harmonicPrompt db "The harmonic mean will be returned to the driver.",10,0

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
call printf                             ; Print out intructions prompt.
pop rax

push qword 0
mov rax, 0                    
mov rdi, instructions2
call printf                             ; Print out intructions2 prompt.
pop rax

;---------------------------CALL FUNCTION INPUT_ARRAY---------------------------------------

mov rdi, floatArray                     ; Pass array into rdi register.
mov rsi, array_size                     ; Pass the max array size into rsi register.
call fill                               ; Call funtion to input array.
mov r14, rax                            ; Put number of elements in array in r14.

;-------------------------CONFIRM INPUTTED VALUES--------------------------------

;{ Print numbers entered prompt.
push qword 0
mov rax, 0
mov rdi, enteredPrompt
call printf
pop rax
;}

mov r15, floatArray                     ; Put array into r15.
mov r13, 0                              ; Counter to iterate through array.

;----------------------------DISPLAY ELEMENTS OF ARRAY--------------------------------------
; Calls display_array that prints out each integer in the array seperated by 1 space.

push qword 0
mov qword rdi, floatArray               ; Pass the array as first parameter.
mov qword rsi, r14                      ; Pass # of elements in the array stored in r14.
call displayArray                       ; Call display_array function.
pop rax

;-----------------------------------CALLS SUM-----------------------------------------------
; Calls function sum to return the sum of integers in the array

push qword 0
mov qword rdi, floatArray               ; Pass the array as first parameter.  
mov qword rsi, r14                      ; Pass # of elements in the array stored in r14.
;mov qword rax, 0
call harmonic                                ; Function sum to add all the integers in array. 
movsd xmm11, xmm0
pop rax

;---------------------------------PRINTS OUT SUMPROMPT-------------------------------------- 
mov rax, 0                    
mov rdi, harmonicPrompt
call printf                            


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
