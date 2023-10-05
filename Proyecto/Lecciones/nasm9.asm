%include        './macros.asm'				;Incluye el archivo utilitario "macros.asm"

section .data                                           ; Segmento de Datos
    ; --Constantes ligadas al Kernel--
        sys_exit        EQU 	1
        sys_read        EQU 	3
        sys_write       EQU 	4
        sys_open        EQU     5
        sys_close       EQU     6
        sys_execve      EQU     11
        stdin           EQU 	0
        stdout          EQU 	1
    ;--Variables de Impresion en Pantalla--
	msgMenu		db '	       		Hola soy un Menu Principal',10,10
		        db '			Elija alguna opcion:',10
			db ' 			1. Brinco al SUBMenu 1',10
			db ' 			2. Me salgo hacia la terminal',10
	lenMsgMenu	equ $ - msgMenu

        msgSubMenu1     db '                    Hola soy el SUBMenu 1',10,10
                        db '                    Elija alguna opcion:',10
                        db '                    1. Realizo la lectura del archivo readme.txt',10
                        db '                    2. Me devuelvo al Menu Principal ',10
        lenMsgSubMenu1  equ $ - msgSubMenu1
	

	msgLecturaArchivo   	db 'Leyendo el contenido de un archivo...',10
	lenMsgLecturaArchivo 	equ $ - msgLecturaArchivo

	archivoREADME db 'readme.txt',0

section .bss                                               ; Segmento de Datos no inicializados
	entrada 		resb 4                     ; Reserva espacio para 4 bytes
	contenidoArchivo  	resb 255		   ; Reserva espacio para 255 bytes

section .text                                              ; Segmento de Codigo
   global _start                                           ; Inicio del Segmento de Codigo

_start:                                                    ; Punto de entrada del programa

	imprimeEnPantalla msgMenu, lenMsgMenu 
	leeTeclado
	cmp byte [entrada],'1'
	je MENU_OPCION1
	cmp byte [entrada],'2'
	je MENU_OPCION2


MENU_OPCION1:
	imprimeEnPantalla msgSubMenu1, lenMsgSubMenu1
        leeTeclado
        cmp byte [entrada],'1'
        je SUBMENU1_OPCION1
        cmp byte [entrada],'2'
        je SUBMENU2_OPCION2

MENU_OPCION2:
	jmp FIN

SUBMENU1_OPCION1:
	imprimeEnPantalla msgLecturaArchivo, lenMsgLecturaArchivo	
	abreArchivo archivoREADME
	leeArchivo contenidoArchivo
	despliegaContenidoArchivo contenidoArchivo
	cierraArchivo archivoREADME
	

SUBMENU2_OPCION2:
	jmp _start

	
FIN:	
	salir 
