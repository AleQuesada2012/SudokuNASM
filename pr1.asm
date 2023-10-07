;objetivo de la macro: sale del programa hacia la terminal
;ejemplo de funcionamiento: salir
;ejemplo de uso: salir
%macro salir 0
    mov eax,1
	mov ebx,0
    int 80h
%endmacro

	;objetivo de la macro: imprimir un texto en pantalla
	;ejemplo de funcionamiento: imprimeEnPantalla variableEnMemoria variableEnMemoria
	;ejemplo de uso:            imprimeEnPantalla mensaje longitudMensaje
        %macro imprimeEnPantalla 2
                mov     eax, sys_write     	; opción 4 de las interrupciones del kernel.
                mov     ebx, stdout        	; standar output.
                mov     ecx, %1            	; mensaje.
                mov     edx, %2            	; longitud.
                int     0x80
        %endmacro

    ;objetivo de la macro: captura un dato ASCII ingresado por teclado por parte del usuario y almacena la entrada en la variable de memoria "entrada"
	;ejemplo de funcionamiento: leeTeclado
	;ejemplo de uso:	    leeTeclado
        %macro leeTeclado 0
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     entrada       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8             ; número de bytes a leer.
                int     0x80
        %endmacro


section .bss
    entrada: resb 1     ; digito de entrada
    coord1: resb 1      ; posicion x
    coord2: resb 1      ; posicion y

section .data ; segmento de datos y variables

    ; --Constantes ligadas al Kernel--
        sys_exit        EQU 	1
        sys_read        EQU 	3
        sys_write       EQU 	4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU 	0
        stdout          EQU 	1


menuInicio: db 'Bienvenido al Juego de SUDOKU!', 10, 10, 'Seleccione una opcion:', 10, '1. Iniciar juego', 0xA, '2. Salir', 10, 0
longMenu: equ $-menuInicio

;cada caracter del tablero es un byte, para recorrerlo hay que ir byte por byte
tableroVacio: db '[ ] | [ ] | [ ]', 10, '[ ] | [5] | [ ]', 0xA, '[ ] | [ ] | [ ]', 0xA, 0
longTableroV equ $-tableroVacio

entradaEquivocada: db 'Entrada equivocada. Intente de nuevo!', 10, 10
longEntEq equ $-entradaEquivocada

; agregar aqui los 3 tableros posibles que vienen en el documento con 5 casillas eliminadas

; los 3 tableros (en una sola linea cada uno, ordenados por fila, son así)
; tablero 1: 4 9 2, 3 5 7, 8 1 6
; tablero 2: 2 9 4, 7 5 3, 6 1 8
; tablero 3: 6 1 8, 7 5 3, 2 9 4

despedida: db 'Gracias por jugar!', 10
longDespedida equ $-despedida



; mensajes de depuración
;dbg_msg1: db 'entrada a start alcanzada', 0
;longmsg1 equ $-dbg_msg1

;dbg_msg2: db 'entrada a mostrar tablero alcanzada', 0
;longmsg2 equ $-dbg_msg2

;dbg_msg3: db 'entrada a salir del juego alcanzada', 0
;longmsg3 equ $-dbg_msg3

;mensaje: db 'Inserte un número: ', 0, 0
;longitud equ $-mensaje

section .text

global _start

_start:

Inicio:
    ;xor rax, rax
    ;xor rbx, rbx
    imprimeEnPantalla menuInicio, longMenu
    leeTeclado      ; carga la variable a entrada
    cmp byte [entrada], '1' ; compara con el valor ASCII de 1
    je mostrar_tablero
    cmp byte[entrada], '2'
    je cerrar_juego

    imprimeEnPantalla entradaEquivocada, longEntEq
    jmp Inicio



mostrar_tablero:
    imprimeEnPantalla tableroVacio, longTableroV
    jmp SALIR
    ; aqui habria que agregar la logica para procesar la entrada


cerrar_juego:
    imprimeEnPantalla despedida, longDespedida
    jmp SALIR



SALIR:
    salir