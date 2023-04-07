section .data
    string db '1337', 0
    string_len equ $-string
section .bss
    input resb 4 ; allouer 4 octets pour stocker l'entree utilisateur

global _start

section .text
_start:

    pop ecx        ; argc in ecx
    add esp, 4        ; on bouge le pointeur de la stack à esp + 4 pour 
récupere l'adresse de arg1
    mov ecx, [esp]    ; On recupere la valeur de arg1 dans ecx

    cmp byte[ecx], 0x34 
    jne exit
    cmp byte[ecx+1], 0x32
    jne exit

    mov eax, 4
    mov ebx, 1
    mov ecx, string
    mov edx, string_len
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h


exit:

    mov eax, 1
    mov ebx, 1
    int 80h
