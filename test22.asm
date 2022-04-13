%include "rw32-2022.inc"

section .data
    task21A dw 192,64,-112,-16,32,-48,-960,-944
    task21B dw 26404,8931,19807,27388,7738,-16257,29979,27114
    task22A db 96,64,20,44,56,36,-192,-188
    task22B db 130,21,29,152,184,253,251,26
    task23A dd 6144,4096,1280,2816,3584,2304,-12288,-12032
    
    pole db 1, -2, 3, 4
    hledat dd 6
    len dd 4

CEXTERN malloc
section .text
CMAIN:
    push ebp
    mov ebp,esp
                
    mov eax,task21A
    mov BX,-112
    mov ecx,8
    call task21

    push dword pole
    push dword [len]
    push dword [hledat]
    ; eax = task22(task22A,8,0)
    call task22

    
    mov ecx,2
    call task23

    pop ebp
    ret    
;
;--- Task 1 ---
;
; Create a function 'task21' to find if there is a value in an array of the 16bit signed values.  
; Pointer to the array is in the register EAX, the value to be found is in the register BX 
; and the count of the elements of the array is in the register ECX.
;
; Function parameters:
;   EAX = pointer to the array of the 16bit signed values (EAX is always a valid pointer)
;   BX = 16bit signed value to be found
;   ECX = count of the elements of the array (ECX is an unsigned 32bit value, always greater than 0)
;
; Return values:
;   EAX = 1, if the value has been found in the array, otherwise EAX = 0
;
; Important:
;   - the function does not have to preserve content of any register
;

task21:
    .for:
        cmp bx, word [eax + (ecx-1) * 2]
        je .found
        loop .for
    mov eax, 0
    jmp .return
        
    .found:
        mov eax, 1   
    .return:
        ret
;
;--- Task 2 ---
;
; Create a function: void* task22(const unsigned char *pA, int N, unsigned char x) to search an array pA of N 8bit unsigned
; values for the last occurrence of the value x. The function returns pointer to the value in the array.
; The parameters are passed, the stack is cleaned and the result is returned according to the PASCAL calling convention.
;
; Function parameters:
;   pA: pointer to the array A to search in
;    N: length of the array A
;    x: value to be searched for
;
; Return values:
;   EAX = 0 if the pointer pA is invalid (pA == 0) or N <= 0 or the value x has not been found in the array
;   EAX = pointer to the value x in the array (the array elements are indexed from 0)
;
; Important:
;   - the function MUST preserve content of all the registers except for the EAX and flags registers.
;


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
    
    mov eax, -1
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

;
;--- Task 3 ---
;
; Create a function 'task23' to allocate and fill an array of the 32bit unsigned elements by the elements
; of the Padovan sequence P(0), P(1), ... , P(N-1). Requested count of the elements of the Padovan sequence
; is in the register ECX (32bit signed integer) and the function returns a pointer to the array
; allocated using the 'malloc' function from the standard C library in the register EAX.
;
; Elements of the Padovan sequence are defined as follows:
;
;   P(0) = 1
;   P(1) = 1
;   P(2) = 1
;   P(n) = P(n-2) + P(n-3)
;
; Function parameters:
;   ECX = requested count of the elements of the Padovan sequence (32bit signed integer).
;
; Return values:
;   EAX = 0, if ECX <= 0, do not allocate any memory and return value 0 (NULL),
;   EAX = 0, if memory allocation by the 'malloc' function fails ('malloc' returns 0),
;   EAX = pointer to the array of N 32bit unsigned integer elements of the Padovan sequence.
;
; Important:
;   - the function MUST preserve content of all the registers except for the EAX and flags registers,
;   - the 'malloc' function may change the content of the ECX and EDX registers.
;
; The 'malloc' function is defined as follows:
;
;   void* malloc(size_t N)
;     N: count of bytes to be allocated (32bit unsigned integer),
;     - in the EAX register it returns the pointer to the allocated memory,
;     - in the EAX register it returns 0 (NULL) in case of a memory allocation error,
;     - the function may change the content of the ECX and EDX registers.
task23:
    push ebp
    mov ebp, esp
    
    push ebx
    push edx
    push esi
    push edi
    
    mov eax, 0
        
    cmp ecx, 0
    jle .return
    
    shl ecx, 2
    push ecx
    call malloc
    pop ecx
    cmp eax, 0
    je .return
    shr ecx, 2
    
    
    cmp ecx, 1
    jne .dva
    mov [eax], dword 1
    jmp .return
    
    .dva:
    cmp ecx, 2
    jne .tri
    mov [eax], dword 1
    mov [eax + 4], dword 1
    jmp .return
    
    .tri:
    cmp ecx, 3
    jne .vic
    mov [eax], dword 1
    mov [eax + 4], dword 1
    mov [eax + 8], dword 1
    jmp .return
    
    .vic:
    mov [eax], dword 1
    mov [eax + 4], dword 1
    mov [eax + 8], dword 1
    mov edx, dword 3
    .for:
        cmp edx, ecx
        jge .return
        mov esi, [eax + (edx - 2) * 4]
        mov edi, [eax + (edx - 3) * 4]
        lea ebx, [esi + edi]
        mov [eax + edx * 4], ebx  
        inc edx
        jmp .for
    
    .return:
    
    pop edi
    pop esi
    pop edx
    pop ebx
    
    pop ebp
    ret
