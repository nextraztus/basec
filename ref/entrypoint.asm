; vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
;
; test.asm -- example entrypoint
;

;;;;;;;;;;;;;;;;;;;; Initialized Data
SECTION .data

msgtoprint: db "One small step below C, one giant leap for Sam.",10
msglen:     equ $-msgtoprint

;;;;;;;;;;;;;;;;;;;; Uninitialized Data
SECTION .bss

;;;;;;;;;;;;;;;;;;;; Executable Code
SECTION .text

global _start

_start:                     ; Entry Point
    nop                     ; give our debugger something to work with

    mov eax,4               ; sys_write syscall
    mov ebx,1               ; use stdout (FD 1)
    mov ecx,msgtoprint      ; offset of message
    mov edx,msglen          ; length of message
    int 80H                 ; invoke syscall (sys_write message)

    mov eax,1               ; exit syscall
    mov ebx,0               ; return code 0
    int 80H                 ; invoke syscall (terminate program)


