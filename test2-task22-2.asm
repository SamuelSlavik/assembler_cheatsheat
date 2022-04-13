; ebp + 16  pA
; ebp + 12  N
; ebp +  8  x
; ebp +  4  ret
; ebp +  0  stare ebp
task22:
    push ebp
    mov ebp, esp
    
    push ebx
    push ecx
    push edx
    
    mov eax, 0
    cmp [ebp + 16], dword 0
    je .end
    cmp [ebp + 12], dword 0
    jle .end
    
    mov ebx, [ebp + 16] ; ebx = pA
    mov ecx, [ebp + 12] ; ecx = N
    mov dl, byte [ebp +  8] ; edx = x
    
    .for:
        cmp dl, byte [ebx + (ecx - 1) * 1]
        jne .not_equal
        lea eax, [ebx + (ecx -1) * 1]
        .not_equal:
            loop .for    
    
    .end:
    pop edx
    pop ecx
    pop ebx
    
    pop ebp
    ret 4*3
