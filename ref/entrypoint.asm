; vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
;
; entrypoint.asm -- example entrypoint
;

;;;;;;;;;;;;;;;;;;;; Initialized Data
SECTION .data
    msg:        db "Goodbye, universe!"
    msglen:     equ $-msg

;;;;;;;;;;;;;;;;;;;; Uninitialized Data
SECTION .bss

;;;;;;;;;;;;;;;;;;;; Executable Code
SECTION .text
    global main

main:                       ; Entry Point
    mov rax, 1              ; sys_write syscall
    mov rdi, 1              ; use stdout (fd 1)
    mov rsi, msg            ; offset of message
    mov rdx, msglen         ; length of message
    syscall

    mov rax, 60             ; sys_exit syscall
    mov rdi, 0              ; return code 0
    syscall                 ; terminate


