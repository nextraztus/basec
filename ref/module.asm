; vim: set expandtab tabstop=4 shiftwidth=4 autoindent smartindent:
;
; module.asm -- example module
;

;;;;;;;;;;;;;;;;;;;; Initialized Data
SECTION .data

;;;;;;;;;;;;;;;;;;;; Uninitialized Data
SECTION .bss

;;;;;;;;;;;;;;;;;;;; Executable Code
SECTION .text

global _asmadd
_asmadd:                    ; routine name
    nop                     ; for debugging

    push ebp                ; create a stack frame
    mov ebp,esp

    mov eax,[ebp+8]         ; first argument
    mov ebx,[ebp+12]        ; second argument
    add eax, ebx            ; add them together

    pop ebp                 ; restore our base pointer
    ret

