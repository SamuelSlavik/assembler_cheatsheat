%include "rw32-2022.inc"

section .data
    pole dd 10,20,35,-5,15,100, 150,200
    hodnota dd 35
    pocet dd 8

section .text
_main:

; najdi rovnake cisla v poli

    push ebp
    mov ebp, esp
    mov eax, pole
    mov ebx, [hodnota]
    mov ecx, [pocet]
    push eax
    push ebx 
    push ecx
    call task21
    call WriteInt32

    pop ebp
    ret

    task21:
    push ebp
    mov ebp,esp
    push eax
    push ebx
    push ecx
    mov eax,[ebp+20]
    mov ebx,[ebp+16]
    mov ecx,[ebp+12]
    .for:
    dec ecx
    cmp ebx,[eax+ecx4]
    je .equal
    jne .end
    mov ebx,[eax+ecx4] 
    .equal: ;zevraj zbytocne
    mov eax,1

    .end:
    mov eax,0



    pop ebp
    ret
