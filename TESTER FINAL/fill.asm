; // Author information
; //  Author name: Stefan Parrish
; //  Author email: parrishstefan@fullerton.edu
; //  ENROLLED IN SECTION 07
; //  TOOK TEST FROM SECTION 1&5

extern printf
extern scanf
extern isfloat
extern stringtofloat

global fill                       ; Makes function callable from other linked files.

section .data
    inputStr       db "%s", 0
    outputDbl      db "%lf", 10, 0
    outputArray    db "[%d, %d]: %lf", 10, 0

section .bss

fill.float resb 32

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
push qword 99
mov rax, 0
mov rdi, inputStr
mov rsi, fill.float
call scanf
pop r8

; Test if Control + D is entered to finish inputting into array.
cdqe
cmp rax, -1                          
je end_loop                             ; Exit loop if control + D is pressed.

mov rax, 0
mov rdi, fill.float
call isfloat
mov r12, rax

;INVALID ENTRY
cmp r12, 0
je begin_loop
;

mov rax, 0
mov rdi, fill.float
call stringtofloat
movq xmm11, rax

;--------------------------------COPY INTO ARRAY IF VALID INPUT--------------------------------------------
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
