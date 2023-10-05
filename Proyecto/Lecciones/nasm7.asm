%macro mensaje 2
      mov   eax, 4
      mov   ebx, 1
      mov   ecx, %1
      mov   edx, %2
      int   80h
%endmacro

section .data

msg1 db 'Hola, usando la macro para desplegar el primer mensaje',0,10,13
long1 equ $-msg1

msg2 db 'Hola, usando la macro para desplegar el segundo mensaje',0,10,13
long2 equ $-msg2

msg3 db 'Hola, usando la macro para desplegar el tercer mensaje',0,10,13
long3 equ $-msg3

section .text

global _start:

_start:
mensaje msg1,long1
mensaje msg2,long2
mensaje msg3,long3

mov eax,1
int 80h
