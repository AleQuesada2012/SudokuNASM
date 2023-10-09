

;objetivo de la macro: sale del programa hacia la terminal
;ejemplo de funcionamiento: salir
;ejemplo de uso: salir

%macro salir 0
    mov eax,1
	mov ebx,0
    int 80h
%endmacro

%macro leer3Inputs 0
 ; Read the first number from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, coord1
    mov edx, 1
    int 0x80


    ; Read the second number from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, coord2
    mov edx, 1
    int 0x80


    ; Read the third number from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, numCasilla
    mov edx, 1
    int 0x80
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
                mov     edx,     64             ; número de bytes a leer.
                int     0x80
        %endmacro



   



%macro capturaNumero 1
                mov     eax, [coordLista]         ; pasa el contenido en la variable de memoria "entrada" y la transfiere al registro eax quitando la parte ASCII
                sub     eax, 48                ; realiza la resta eax - 48 , la idea es obtener el valor numerico del valor de entrada y no su correspondiente ASCII
                mov     [%1], eax              ; transfiere el contenido del registro eax hacia el contenido de la variable de memoria ingresada en el parametro uno 
        %endmacro


section .bss
    entrada: resb 10     ; digito de entrada
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


;cada caracter del tablero es un byte, para recorrerlo hay que ir byte por byte
tablero0: db "[ ] | [ ] | [ ]", 10, "[ ] | [5] | [ ]", 0xA, "[ ] | [ ] | [ ]", 0xA, 0
longTablero equ $-tablero0 ; en principio, las longitudes deberian ser iguales
tablero1: db "[ ] | [9] | [ ]", 10, "[ ] | [5] | [ ]", 0xA, "[8] | [ ] | [6]", 0xA, 0
tablero1sol: db "[4] | [9] | [2]", 10, "[3] | [5] | [7]", 0xA, "[8] | [1] | [6]", 0xA, 0

tablero2: db "[4] | [ ] | [2]", 10, "[ ] | [5] | [ ]", 0xA, "[8] | [ ] | [ ]", 0xA, 0
tablero2sol: db "[4] | [9] | [2]", 10, "[3] | [5] | [7]", 0xA, "[8] | [1] | [6]", 0xA, 0


tablero3: db "[4] | [ ] | [ ]", 10, "[3] | [5] | [ ]", 0xA, "[ ] | [1] | [6]", 0xA, 0


tablero4: db "[ ] | [9] | [ ]", 10, "[ ] | [5] | [3]", 0xA, "[6] | [ ] | [ ]", 0xA, 0


tablero5: db "[2] | [ ] | [4]", 10, "[ ] | [5] | [ ]", 0xA, "[ ] | [1] | [ ]", 0xA, 0
tablero5sol: db "[2] | [9] | [4]", 10, "[7] | [5] | [3]", 0xA, "[6] | [1] | [8]", 0xA, 

tablero6: db "[ ] | [ ] | [ ]", 10, "[7] | [5] | [ ]", 0xA, "[ ] | [ ] | [8]", 0xA, 0
tablero6sol: db "[2] | [9] | [4]", 10, "[7] | [5] | [3]", 0xA, "[6] | [1] | [8]", 0xA,

tablero7: db "[ ] | [1] | [ ]", 10, "[ ] | [5] | [3]", 0xA, "[ ] | [9] | [ ]", 0xA, 0
tablero7sol: db "[6] | [1] | [8]", 10, "[7] | [5] | [3]", 0xA, "[2] | [9] | [4]", 0xA, 0

tablero8: db "[6] | [ ] | [ ]", 10, "[ ] | [5] | [3]", 0xA, "[2] | [ ] | [ ]", 0xA, 0
tablero8sol: db "[6] | [1] | [8]", 10, "[7] | [5] | [3]", 0xA, "[2] | [9] | [4]", 0xA, 0

tablero9: db "[ ] | [ ] | [ ]", 10, "[7] | [5] | [ ]", 0xA, "[ ] | [ ] | [4]", 0xA, 0
tablero9sol: db "[6] | [1] | [8]", 10, "[7] | [5] | [3]", 0xA, "[2] | [9] | [4]", 0xA, 0

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


mensajeCoordenadas: db 'Inserte el número correspondiente a agregar y sus coordenadas: ',0,0
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
    ; AQUI VOY A EMPEZAR A COMPARAR y seleccionar LOS TABLEROS
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
               ; second value on the stack is the program name (discarded when we initialise edx)
    leeTeclado
    jmp Valida_Coordenadas2


Valida_Coordenadas2:             ; puedo hacerla esta una macro

    ;mov [coord1], ecx
    ;call skip_whitespace
    ;mov [coord2], ecx
    ;call skip_whitespace
    ;mov [numCasilla], ecx
    
    
    cmp byte[entrada], '0'       ; operacion
    je coordenada_0

    cmp byte[entrada], '1'
    je coordenada_1

    cmp byte[entrada], '2'
    je coordenada_2

   


coordenada_0:
  
    ;add ecx, 2
    leeTeclado
    cmp byte[entrada], '0'
    je tp1

    cmp byte[entrada], '1'
    je tp2

    cmp byte[entrada], '2'
    je tp3

tp1:
    
    mov edx, 1     ; en ecx va a quedar uno
    ;dec ecx
    jmp Valida_Valor                ;   AQUI OCUPO FUNCION PARA CABIAR EL NUMERO, VALIDAR SI HAY O NO NUMERO Y ETC
tp2:
    
    mov edx, 7        ; probar sin parentesis
    ;dec ecx
    jmp Valida_Valor
tp3:
    mov edx, 13
    ;dec ecx
    jmp Valida_Valor

coordenada_1:
    ;dec ecx
    ;add ecx, 2
    leeTeclado
    cmp byte[entrada], '0'
    je tp4

    cmp byte[entrada], '1'
    je tp5

    cmp byte[entrada], '2'
    je tp6

tp4:
    mov edx, 17
    jmp Valida_Valor
tp5:
    mov edx, 23
    jmp Valida_Valor
tp6:
    mov edx, 29
    ;dec ecx
    jmp Valida_Valor
    
coordenada_2:  
    ;dec ecx
    ;add ecx, 2
    leeTeclado
    cmp byte[entrada], '0'
    je tp7
   
    cmp byte[entrada], '1'
    je tp8
    
    cmp byte[entrada], '2'
    je tp9
    
tp7:
    mov edx, 33
    jmp Valida_Valor
tp8:
    mov edx, 39
    jmp Valida_Valor
tp9:
    mov edx, 45                 ; en eax estan los saltos correspondientes a las coordenadas
    jmp Valida_Valor


Valida_Valor:
        ;mov al, [esi]
        ;cmp edx, 0              ; brinca si el taguet position es cero
        add esi, edx     
        je replace_space

        ;inc esi
        ;dec edx

replace_space:
    ;mov bl, [numCasilla]           ; el imput del numero
    add ecx, 2                      ; aqui se incrementa la entrada para agarrar el numero de casilla
    mov byte [esi], '#'             ; compara si la casilla no tiene nada
    ;mov esi,0
    sub esi, edx
    mov edx, 0       
    jmp Casilla_Vacia
    ;jne Casilla_No_Vacia



printMessage: 
    mov eax, 4          ; syscall number for write
    mov ebx, 1          ; file descriptor (stdout)
    mov ecx, tablero1    ; pointer to the message
    mov edx, 49         ; message length (excluding null terminator)
    int 0x80            ; invoke the syscall
    jmp Pedir_Coordenadas





Casilla_Vacia:
    jmp printMessage


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
