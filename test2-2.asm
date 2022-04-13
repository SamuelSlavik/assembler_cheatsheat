%include "rw32-2018.inc"

section .data
    pA dd 1,2,3,4,5
    x dd 3
    counter dd 5
section .text
_main:
    push ebp
    mov ebp, esp
    mov eax, pA
    mov ecx, [counter]
    mov ebx, [x]
    
    call task21
    ; zde bude vas kod
    push pA
    push dword [counter]
    push dword [x]
    
    

    
    
    call task22
    pop ebp
    ret

task21:
    push ebp 
    mov ebp,esp
    .for:
        cmp ecx, 0
        jle .forend
        cmp [eax + ecx*4 -4], ebx
        je .same
        dec ecx
        jmp .for
    .notfound:
        mov eax,0
        jmp .forend
    .same:
        mov eax,1
        jmp .forend
    .forend:
    pop ebp
    ret
    
task22:
    push ebp
    mov ebp,esp
    push ebx
    push ecx
    xor eax,eax
    mov eax,[ebp+16] ;pole
    mov ebx,[ebp+8] ;co hladame
    mov ecx,[ebp+12] ;counter
    cmp eax,0
    jz .notfound
    cmp ecx,0
    jle .notfound
    .for:
        cmp ecx, 0
        jle .forend
        cmp [eax + ecx*4 -4], ebx
        je .same
        dec ecx
        jmp .for
    .notfound:
        mov eax,0
        jmp .forend
    .same:
        xor eax,eax
        lea eax, [eax+4*ecx-4]
        jmp .forend
    .forend:
    pop ecx
    pop ebx
    pop ebp
    ret 3*4
