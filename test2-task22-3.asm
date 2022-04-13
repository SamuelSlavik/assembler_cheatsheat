task22:
    push ebp
    mov ebp, esp
    push esi
    push ecx

    mov esi, [ebp + 8]
    mov ecx, [ebp + 12]

loop1:
    ;lodsb
    mov al, [esi]
    add esi, 1
    ;al = aktualny prvok pola

    loop loop1   
     
    pop ecx
    pop esi
    
    mov esp, ebp  
    pop ebp
    ret 4*3
