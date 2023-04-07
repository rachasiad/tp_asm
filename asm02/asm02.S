section .data
    string db "1337", 0
    string_len equ $-string

section .bss
    input resb 4 ; allouer 4 octets pour stocker l'entree utilisateur

section .text
    global _start

_start:

    mov eax, 3 ; 3 = Syscall read
    mov ebx, 0 ; On défini le fd sur stdin
    mov ecx, input ;
    mov edx, 4 ; Longueur maximale de la saisie
    int 80h

    cmp byte[input], 0x34
    jne _error
    cmp byte[input+1], 0x32
    jne _error
    cmp byte[input+2], 0
    jne _error

    mov eax, 4 ; 4 = Syscall write --> permettant le print
    mov ebx, 1 ; On defini le fd sur stdout
    mov ecx, string ; Pointeur sur notre string
    mov edx, string_len ; On défini ici la longeur du message
    int 80h ; On syscall

    mov eax, 1
    mov ebx, 0
    int 80h

_error:
    mov eax, 1
    mov ebx, 1 ; On renvoi un si l'entrée n'est pas 42
    int 0x80
