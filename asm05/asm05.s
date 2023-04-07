section .data
    const10:    dd 10
    
section .bss
    input1 resd 1 ;
    num1 resd 1 ;
    num2 resd 1 ;
    num3 resd 1 ;

global _start

section .text
_start:
    mov eax , [esp+8]      ; On récupère la valeur de arg1 dans eax
    
    xor edx, edx
    mov esi, eax         ; copier l'adresse de arg1 dans esi
    xor ebx, ebx

convert_to_int1:
    mov bl, [esi]        ; charger le caractère suivant
    cmp bl, 0            ; vérifier si c'est la fin de la chaîne
    je v2   ; si c'est la fin, aller au 2e atoi
    sub bl, 48           ; convertir le caractère en nombre
    imul edx, 10         ; multiplier la somme actuelle par 10
    add edx, ebx         ; ajouter le nombre au résultat
    inc esi              ; aller au caractère suivant
    jmp convert_to_int1   ; répéter


v2:
	xor edi,edi
	mov edi, edx
	
    mov ebx , [esp+12]      ; On récupère la valeur de arg2 dans ebx
    
    xor edx, edx
    mov esi, ebx         ; copier l'adresse de arg1 dans esi
    xor ebx, ebx

convert_to_int2:
    mov bl, [esi]        ; charger le caractère suivant
    cmp bl, 0            ; vérifier si c'est la fin de la chaîne
    je addition   ; si c'est la fin, aller au 2e atoi
    sub bl, 48           ; convertir le caractère en nombre
    imul edx, 10         ; multiplier la somme actuelle par 10
    add edx, ebx         ; ajouter le nombre au résultat
    inc esi              ; aller au caractère suivant
    jmp convert_to_int2   ; répéter

addition:

	
    add edx, edi
    mov eax, edx
    
    
    xor ebx,ebx
    xor ecx,ecx
    xor edx,edx
    xor esi,esi
    xor edi,edi
    
printNumber:
    xor edx,edx          ;edx:eax = number
    div dword [const10]  ;eax = quotient, edx = remainder
    
    cmp eax, 10
    jge greater_than_10
    jl less_than_10

greater_than_10:
    add edx, 48
    mov [num3], edx
    jmp next

less_than_10:
    cmp eax, 0
    je printReste
    add edx, 48
    mov [num2], edx
    jmp next
    
next:    
    cmp eax, 0
    je printReste
    jmp printNumber
    
    ;si eax =/ 0 --> Print edx
    ;sinon jump printReste
    

printReste:
    add edx, 48
    mov [num1], edx
    
    xor eax, eax
    mov eax, 4
    mov ebx, 1
    mov ecx, num1
    mov edx, 1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, num2
    mov edx, 1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, num3
    mov edx, 1
    int 0x80
    
    
    mov eax, 1 ; syscall pour terminer le programme
    xor ebx, ebx
    int 0x80
