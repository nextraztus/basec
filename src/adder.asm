; vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
;
; adder.asm -- example module
;

;;;;;;;;;;;;;;;;;;;; Initialized Data
SECTION .data

;;;;;;;;;;;;;;;;;;;; Uninitialized Data
SECTION .bss

;;;;;;;;;;;;;;;;;;;; Executable Code
SECTION .text

global asmadd
asmadd:                     ; routine name
    push rbp                ; create a stack frame
    mov rbp, rsp

    mov rax, rdi            ; first argument (long int)
    add rax, rsi            ; second argument (long int)

    pop rbp
    ret
