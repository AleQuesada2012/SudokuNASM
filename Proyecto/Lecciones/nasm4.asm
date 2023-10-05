section .data
mens1	db "El resultado es: ",10,13
longmens1  equ $-mens1

segment .bss
resultado resb 1

section .text

global _start

_start:

	xor eax,eax
	xor ecx,ecx
	mov ecx,'2'
	sub ecx,'0'
	call cuadrado
	mov [resultado],eax

	mov ecx,resultado
	mov edx,1
	mov ebx,1
	mov eax,4
	int 80h

	mov ebx,0
        mov eax,1
        int 80h

cuadrado:

	mov eax,ecx
	imul ecx
	add eax, '0'
	ret

