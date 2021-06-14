;Author information
;  Author name   : Clemente Solorio
;  Author email  : clem@csu.fullerton.edu
;  Author section: Section-05
;===================================================== BEGIN CODE AREA ======================================================
extern scanf
extern printf
extern isfloat
extern atof

global fill

segment .data:
    prompt_one db "Enter float numbers separated by white space. Invalid inputs will be omitted.", 10, 0
    instructions db "Enter control+D to terminate.", 10, 0
    floatformat db "%lf", 0
    stringformat db "%s", 0

segment .bss

segment .text

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

push qword 0                       ; Extra push to create even number of pushes

;-----------------------------INITIALIZE PARAMETERS-----------------------------------------

mov qword r15, rdi                 ; Address of array saved to r15.
mov qword r14, rsi                 ; Max number of elements allowed in array.
mov qword r13, 0                   ; set the counter of elements to 0

;-----------------------------INSTRUCTIONS DISPLAY------------------------------------------

;Block to display the prompt message
mov qword rax, 0
mov qword rdi, prompt_one          ; "Enter float numbers separated by white space. Invalid inputs will be omitted."
call printf

;Block to display the instructions
mov qword rax, 0
mov qword rdi, instructions        ; "When finished press enter followed by cntl+D."
call printf

;==================================================== START OF THE LOOP ======================================================

beginloop:
sub rsp, 256
;Scanf block to get a number from user input.
push qword 0
mov qword rax, 0
mov qword rdi, stringformat
mov qword rsi, rsp
call scanf

cdqe                               ; cdqe occupies the full rax register to prevent junk in rax.
;CNTL+D CASE EXIT
cmp rax, -1                        ; scanf returns -1 for a cntl+D by the user.
je endloop                         ; if the user wants to exit, jump out of the loop

mov qword rdi, rsp
call isfloat
mov r10, rax                       ; isfloat returns a 0 or non zero. make a copy of the result to check for validity

cmp r10, 0
je bottom_loop

mov qword rax, 0
mov qword rdi, rsp
call atof
movsd xmm15, xmm0
add rsp, 256

;----------------------------------COPY NUM INTO THE ARRAY----------------------------------
pop r8
movsd [r15 + 8 * r13], xmm15       ; move the value into the next quadword of the array in memory.
inc r13                            ; keep count of how many values are in the array.

;----------------------------------CHECK COUNT AGAINST MAX----------------------------------

bottom_loop:
cmp r13, r14
je exit                            ; if count = max_array_size then jump to end

; if count != max_array_size then restart loop
jmp beginloop                      ; restart loop

endloop:
add rsp, 256
pop rax
jmp exit

;------------------------------------EXIT---------------------------------------------------
exit:

; Restore all backed up registers to their original state.
pop rax                                 
mov rax, r13                      ; Copies # of elements in r13 to rax.
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

