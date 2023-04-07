section .data

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

    mov esi, input
    xor ebx, ebx
    xor eax, eax
    xor ecx, ecx
    xor edx, edx

convert_to_int1:
    mov bl, [esi]        ; charger le caractère suivant
    cmp bl, 0            ; vérifier si c'est la fin de la chaîne
    je isPair   ;
    cmp bx, 0x0A
    je isPair
 
    sub bl, 48           ; convertir le caractère en nombre
    imul edx, 10         ; multiplier la somme actuelle par 10
    add edx, ebx         ; ajouter le nombre au résultat
    inc esi              ; aller au caractère suivant
    jmp convert_to_int1   ; répéter

isPair: 
    mov eax, edx
    xor edx, edx
    mov ebx, 2
    idiv ebx
    cmp edx, 0 ; Si reste = 0 c'est pair !
    je paire

    mov eax, 1
    mov ebx, 1
    int 80h

paire:
    mov eax, 1
    mov ebx, 0
    int 80h
