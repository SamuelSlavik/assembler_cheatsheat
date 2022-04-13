task22:
  push ebp
  mov ebp, esp
  push ebx
  push ecx
  push edx

  ; +16 arr
  ; +12 length
  ; +8  key

  mov eax, [ebp+16]
  cmp eax, 0
  jz invalid ; array is null pointer
  mov ecx, [ebp+12]
  cmp ecx, 0
  jle invalid ; array length is invalid
  mov bx, [ebp+8]

  w:
    mov dx, [eax + ecx*2 - 2]
    cmp bx, dx
    je valid

    loop w

  invalid:
    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    mov eax, 0
    ret 12

  valid:
    push eax

    mov edx, 2
    mov eax, ecx
    mul edx

    pop edx
    add eax, edx
    sub eax, 2

    pop edx
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret 12
