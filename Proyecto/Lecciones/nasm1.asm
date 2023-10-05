
section .data   ; Aqui empieza mi seccion de datos

mensaje: db "Hola desde NASM!!",10,13,10,13
longitud: equ $-mensaje

section .text	; Aqui empieza mi seccion de codigo

global _start:


_start:


	mov edx,longitud
	mov ecx,mensaje
	mov ebx,1
	mov eax,4
	int 0x80

	mov ebx,0
	mov eax,1
	int 80h 

; Ultima Linea
