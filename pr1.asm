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


        %macro imprimeEnPantalla2 2
                mov     eax, sys_write     	; opción 4 de las interrupciones del kernel.
                mov     ebx, stdout        	; standar output.
                mov     esi, %1            	; mensaje.
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



        %macro lee3Teclado 0
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     coord1       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8   
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     coord2       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8   
                mov     eax,     sys_read      ; opción 3 de las interrupciones del kernel.
                mov     ebx,     stdin         ; standar input.
                mov     ecx,     numCasilla       ; dirección de memoria reservada para almacenar la entrada del teclado.
                mov     edx,     8   

                int     0x80
        %endmacro



%macro capturaNumero 1
                mov     eax, [coordLista]         ; pasa el contenido en la variable de memoria "entrada" y la transfiere al registro eax quitando la parte ASCII
                sub     eax, 48                ; realiza la resta eax - 48 , la idea es obtener el valor numerico del valor de entrada y no su correspondiente ASCII
                mov     [%1], eax              ; transfiere el contenido del registro eax hacia el contenido de la variable de memoria ingresada en el parametro uno 
        %endmacro

section .bss
    entrada: resb 1     ; digito de entrada
    coord1: resb 1      ; posicion x
    coord2: resb 1      ; posicion y
    numCasilla: resb 1  ; numero a guardar en la casilla
    coordLista: resb 1  ; coordenada de casilla en el tablero
    coordLista2: resb 1

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

target_position1 equ 1
target_position2 equ 7
target_position3 equ 13
target_position4 equ 17
target_position5 equ 23
target_position6 equ 29
target_position7 equ 33
target_position8 equ 39
target_position9 equ 45

;cada caracter del tablero es un byte, para recorrerlo hay que ir byte por byte
tablero0: db "[ ] | [ ] | [ ]", 10, "[ ] | [5] | [ ]", 0xA, "[ ] | [ ] | [ ]", 0xA, 0
longTablero equ $-tablero0 ; en principio, las longitudes deberian ser iguales
tablero1: db "[ ] | [9] | [ ]", 10, "[ ] | [5] | [ ]", 0xA, "[8] | [ ] | [6]", 0xA, 0
tablero2: db "[4] | [ ] | [2]", 10, "[ ] | [5] | [ ]", 0xA, "[8] | [ ] | [ ]", 0xA, 0
tablero3: db "[4] | [ ] | [ ]", 10, "[3] | [5] | [ ]", 0xA, "[ ] | [1] | [6]", 0xA, 0
tablero4: db "[ ] | [9] | [ ]", 10, "[ ] | [5] | [3]", 0xA, "[6] | [ ] | [ ]", 0xA, 0
tablero5: db "[2] | [ ] | [4]", 10, "[ ] | [5] | [ ]", 0xA, "[ ] | [1] | [ ]", 0xA, 0
tablero6: db "[ ] | [ ] | [ ]", 10, "[7] | [5] | [ ]", 0xA, "[ ] | [ ] | [8]", 0xA, 0
tablero7: db "[ ] | [1] | [ ]", 10, "[ ] | [5] | [3]", 0xA, "[ ] | [9] | [ ]", 0xA, 0
tablero8: db "[6] | [ ] | [ ]", 10, "[ ] | [5] | [3]", 0xA, "[2] | [ ] | [ ]", 0xA, 0
tablero9: db "[ ] | [ ] | [ ]", 10, "[7] | [5] | [ ]", 0xA, "[ ] | [ ] | [4]", 0xA, 0
;los numeros van: 1-7-13-30-43-59-72-85. Entre 30 y 43 está el 5.
; aqui ya se supone que estan los tableros


entradaEquivocada: db 'Entrada equivocada. Intente de nuevo!', 10, 10
longEntEq equ $-entradaEquivocada

; agregar aqui los 3 tableros posibles que vienen en el documento con 5 casillas eliminadas

; los 3 tableros (en una sola linea cada uno, ordenados por fila, son así)
; tablero 1: 4 9 2, 3 5 7, 8 1 6
; tablero 2: 2 9 4, 7 5 3, 6 1 8
; tablero 3: 6 1 8, 7 5 3, 2 9 4

despedida: db 'Gracias por jugar!', 10
longDespedida equ $-despedida


noValidCoord: db 'Casilla no vacía, intente de nuevo', 10
longnoValidCoord equ $-noValidCoord


mensajeTablero: db 'Inserte un número (1 a 9): ', 0, 0
longitud equ $-mensajeTablero


mensajeCoordenadas: db 'Inserte el  número correspondiente a agregar y las coordenadas: ',0,0
longitudCoordenadas equ $-mensajeCoordenadas

mensajeDebug: db 'voy por aqui :)', 0, 0
longitudDebug equ $-mensajeDebug

mensajeD: db 'voy por aca', 0, 0
longitudD equ $-mensajeD

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

    imprimeEnPantalla entradaEquivocada, longEntEq ; llega aquí si la entrada no era 1 ni 2
    jmp Inicio



mostrar_tablero:
    imprimeEnPantalla mensajeTablero, longitud
    leeTeclado ; en caso de que uno quiera pedirle manualmente el tablero que quiere usar
    ; AQUI VOY A EMPEZAR A COMPARAR LOS TABLEROS
    cmp byte [entrada], '1'
    je TABLEROUNO ;imprimeEnPantalla tablero0, longTablero
    cmp byte [entrada], '2'
    je TABLERODOS
    cmp byte [entrada], '3'
    je TABLEROUNOTRES
    cmp byte [entrada], '4'
    je TABLEROCUATRO
    cmp byte [entrada], '5'
    je TABLEROCINCO
    cmp byte [entrada], '6'
    je TABLEROSEIS
    cmp byte [entrada], '7'
    je TABLEROSIETE
    cmp byte [entrada], '8'
    je TABLEROOCHO
    cmp byte [entrada], '9'
    je TABLERONUEVE

    ; aqui habria que agregar la logica para procesar la entrada

    jmp SALIR


TABLEROUNO: ;imprimeEnPantalla tablero0, longTablero
    imprimeEnPantalla tablero1, longTablero
    mov esi, tablero1
    jmp Pedir_Coordenadas
TABLERODOS:
    imprimeEnPantalla tablero2, longTablero
    mov esi, tablero2
    jmp Pedir_Coordenadas
TABLEROUNOTRES:
    imprimeEnPantalla tablero3, longTablero
    mov esi, tablero3
    jmp Pedir_Coordenadas
TABLEROCUATRO:
    imprimeEnPantalla tablero4, longTablero
    mov esi, tablero4
    jmp Pedir_Coordenadas
TABLEROCINCO:
    imprimeEnPantalla tablero5, longTablero
    mov esi, tablero5
    jmp Pedir_Coordenadas
TABLEROSEIS:
    imprimeEnPantalla tablero6, longTablero
    mov esi, tablero6
    jmp Pedir_Coordenadas
TABLEROSIETE:
    imprimeEnPantalla tablero7, longTablero
    mov esi, tablero7
    jmp Pedir_Coordenadas
TABLEROOCHO:
    imprimeEnPantalla tablero8, longTablero
    mov esi, tablero8
   
    jmp Pedir_Coordenadas
TABLERONUEVE:
    imprimeEnPantalla tablero9, longTablero
    mov esi, tablero9
    jmp Pedir_Coordenadas



; AQUI VOY A HACER OTRA FUNCION PARA AGARRAR LAS CASILLAS DEL INPUT


Pedir_Coordenadas:          

    imprimeEnPantalla mensajeCoordenadas, longitudCoordenadas
    lee3Teclado
    
    jmp Valida_Coordenadas

Valida_Coordenadas:         ; puedo hacerla esta una macro

    cmp byte[coord1], '0'
    je cordenada_0

    cmp byte[coord1], '1'
    je cordenada_1

    cmp byte[coord1], '2'
    je cordenada_2


cordenada_0:

    cmp byte[coord2], '0'
    ;mov eax, '1'    
    ;imprimeEnPantalla mensajeDebug, longitudDebug   ; para debuguear lol
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position1
    jmp Valida_Valor               ;   AQUI OCUPO FUNCION PARA CABIAR EL NUMERO, VALIDAR SI HAY O NO NUMERO Y ETC

    cmp byte[coord2], '1'
    ;mov eax, '7'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position2
    jmp Valida_Valor

    cmp byte[coord2], '2'
    ;mov eax, '13'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position3
    jmp Valida_Valor

cordenada_1:
    
    cmp byte[coord2], '0'
    ;mov eax, '17'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position4
    jmp Valida_Valor

    cmp byte[coord2], '1'
    ;mov eax, '23'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position5
    jmp Valida_Valor

    cmp byte[coord2], '2'
    ;mov eax, '29'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position6
    jmp Valida_Valor

cordenada_2:  

    cmp byte[coord2], '0'
    ;mov eax, '33'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position7
    jmp Valida_Valor

    cmp byte[coord2], '1'
    ;mov eax, '39'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position8
    jmp Valida_Valor

    cmp byte[coord2], '2'
    ;mov eax, '45'    
    ;mov [coordLista], eax
    ;capturaNumero coordLista2
    mov ecx, target_position9
    jmp Valida_Valor


Valida_Valor:

        mov al, [esi]
        cmp ecx, 0
        je replace_space
        ;cmp esi, coordLista
        ;je Son_Iguales

        inc esi
        dec ecx

        jmp Valida_Valor

replace_space:
    mov bl, [numCasilla]
    mov byte [esi], bl
    jmp printMessage

;Son_Iguales:
;    mov byte[esi],'#'
;    jmp printMessage
    ;je Casilla_Vacia
    ;jne Casilla_No_Vacia         ; AQUI LO QUE SE DEBE HACER ES CAMBIAR LA CASILLA POR LA VARIABLE numCasilla



printMessage: 
    mov eax, 4          ; syscall number for write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, tablero1    ; pointer to the message
    mov edx, 49         ; message length (excluding null terminator)
    int 0x80            ; invoke the syscall
    jmp Pedir_Coordenadas






Casilla_No_Vacia:
    imprimeEnPantalla noValidCoord, longnoValidCoord
    jmp Pedir_Coordenadas





    ;imprimeEnPantalla mensajeDebug, longitudDebug
    ;jmp SALIR

    



cerrar_juego:
    imprimeEnPantalla despedida, longDespedida
    jmp SALIR



SALIR:
    salir 


SALIR:
    salir 
