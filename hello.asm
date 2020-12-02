; -------------------------
; Program Hello World
; 
; On terminal:
; nasm -f elf64 hello.asm
; ld -s -o hello hello.o
; ./hello
;--------------------------

section .data: ; declaração de variáveis.
    msg db 'Hello, World', 0xa
    len equ $ - msg

section .text:; escremos nosso programa.

global _start:; declaração de método.

_start:
    mov edx, len 
    mov ecx, msg 
    mov ebx, 1
    mov eax, 4
    int 0x80 ; enviar a informação para o kernel
; saída
    mov eax, 1
    mov ebx, 0
    int 0x80