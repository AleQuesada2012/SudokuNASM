section .data
        msg1: db "Hola este es un mensaje que se lee caracter por caracter",0xA,0

section .text
global _start

_start:

mov ecx,msg1

LEER:
        cmp byte[ecx],'o'
        je REEMPLACE

        cmp byte[ecx],0
        je SALIR

        mov eax,4
        mov ebx,1
        mov edx,1
        int 80h

        inc ecx
        jmp LEER

REEMPLACE:
        mov byte[ecx],'i'
        jmp LEER

;Sale al S.O
SALIR:
mov eax,1
mov ebx,0
int 0x80

