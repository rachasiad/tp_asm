section .data
    string db "1337", 0
    string_len equ $-string

section .text
    global _start

_start:
    mov eax, 4 ; 4 = Syscall write --> permettant le print
    mov ebx, 1 ; On defini le fd sur stdout
    mov ecx, string ; Pointeur sur notre string
    mov edx, string_len ; On défini ici la longeur du message
    int 0x80 ; On syscall

    mov eax, 1
    mov ebx, 0
    int 0x80

