%include "rw32-2021.inc"

section .data

    ;data


section .text
CEXTERN malloc
CEXTERN free

fib:
    cmp ecx, 0
    jle fail

    push ecx
    push edx

    shl ecx, 2
    push ecx
    call malloc
    add esp, 4

    pop edx
    pop ecx

    cmp eax, 0
    je fail

    mov dword [eax], 0
    
    cmp ecx, 1
    je end
    
    mov dword [eax + 4], 1
    cmp ecx, 2
    je end

    push ecx
    push edx
    mov edx, ecx
    mov ecx, 2
    push esi
    push edi

loop1:
    mov esi, [eax + ecx * 4 - 8]
    mov edi, [eax + ecx * 4 - 4]
    add esi, edi
    mov [eax + ecx * 4], esi
    
    inc ecx
    cmp ecx, edx
    jb loop1

    pop edi
    pop esi
    pop edx
    pop ecx

    jmp end
fail:
    mov eax, 0
end:
    ret

CMAIN:
    push ebp
    mov ebp,esp

    mov ecx, 11
    call fib
    
    mov esi, eax
    call WriteArrayInt32

    push esi
    call free
    add esp, 4
    
    pop ebp
    ret
