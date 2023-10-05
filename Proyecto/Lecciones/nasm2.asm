
section .data   ; Aqui empieza mi seccion de datos


msgMayor: db "El numero es mayor o igual a 20",10,13
longMsgMayor: equ $-msgMayor
msgMenor: db "El numero es menor que 20",10,13
longMsgMenor: equ $-msgMenor

A: db 10
B: db 11

section .bss
C resb 1

section .text	; Aqui empieza mi seccion de codigo

global _start:


_start:

	xor eax,eax
	mov al,[A]
	add al,[B]
	mov byte [C],al

	cmp byte [C],20
	jge MAYOR

	
	mov edx,longMsgMenor
	mov ecx,msgMenor
	mov ebx,1
	mov eax,4
	int 0x80

	jmp SALIR

MAYOR:

        mov edx,longMsgMayor
        mov ecx,msgMayor
        mov ebx,1
        mov eax,4
        int 0x80
	

SALIR:
	mov ebx,0
	mov eax,1
	int 80h 

; Ultima Linea
