section .data                                                   ; Segmento de Datos
   msgIngreso           db 'Ingrese un numero: '                ; Mensaje #1
   longMsgIngreso       equ $-msgIngreso                		; Longitud del Mensaje #1
   msgNumIngresado      db 'El numero ingresado es: '   		; Mensaje #2
   longNumIngresado equ $-msgNumIngresado                       ; Longitud del Mensaje #2

section .bss                                                                    ; Segmento de Datos no inicializados
   numero resb 5                                                                ; Reserva un 5 bytes

section .text                                                                   ; Segmento de Codigo
   global _start                                                                ; Inicio del Segmento de Codigo

_start:                                                                         ; Punto de entrada del programa

   ; Esta interrupcion con los valores de los registros imprime en pantalla el Mensaje #1
   mov eax, 4
   mov ebx, 1
   mov ecx, msgIngreso
   mov edx, longMsgIngreso
   int 80h

   ; Esta interrupcion con los valores de los registros permite el ingreso del número en pantalla
   mov eax, 3
   mov ebx, 2
   mov ecx, numero
   mov edx, 5
   int 80h


   ; Esta interrupcion con los valores de los registros imprime en pantalla el Mensaje #2
   mov eax, 4
   mov ebx, 1
   mov ecx, msgNumIngresado
   mov edx, longNumIngresado
   int 80h


   ; Esta interrupcion con los valores de los registros imprime el numero ingresado por el usuario
   mov eax, 4
   mov ebx, 1
   mov ecx, numero
   mov edx, 5
   int 80h

SALIR:
   ; Esta interrupcion con los valores de los registros permite salirse del programa
   mov eax, 1
   mov ebx, 0
   int 80h

