; -------------------------
; Program soma
; 
; On terminal:
; nasm -f elf64 soma.asm
; ld -s -o soma soma.o
; ./soma
;--------------------------

section .data
    v1 dw '105', 0xa

section .bss
    buffer: resb 10

section .text
    global _start

_start:

    call convert_value
    call show_value
    
_final:
    mov eax, 1
    mov ebx, 0
    int 0x80

convert_value:
    lea esi, [v1]
    mov ecx, 3
    call string_to_int
    add eax, 1
    ret

show_value:
    lea esi, [buffer]
    call int_to_string

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer 
    mov edx, 10
    int 0x80
    ret 

string_to_int:
    xor ebx, ebx 
.next_digit:
    movzx eax, byte[esi]
    inc esi
    sub al, '0'
    imul ebx, 10
    add ebx, eax 
    loop .next_digit
    mov eax, ebx
    ret 

int_to_string:
    add esi, 9
    mov byte [esi], 0
    mov ebx, 10
.next_digit:
    xor edx, edx
    div ebx 
    add dl, '0'
    dec esi 
    mov [esi], dl 
    test eax, eax 
    jnz .next_digit
    mov eax, esi 
    ret