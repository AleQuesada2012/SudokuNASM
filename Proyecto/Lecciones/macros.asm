;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Macros utiles para programacion en nasm  ;
;  Version 1.0 2022 por emmrami	            ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Si se vna a realizar nuevas macros para un proyecto definirlas aca
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Las siguientes macros se pueden utilizar para los proyectos, si es el caso no modificar las mismas
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

	;objetivo de la macro: abre un archivo para su posterior uso
	;ejemplo de funcionamiento: abreArchivo variableEnMemoria
	;ejemplo de uso:	    abreArchivo nombreArchivo
        %macro abreArchivo 1
                mov     eax,     sys_open      ; opción 5 de las interrupciones del kernel.
                mov     ebx,     %1            ; archivo por abrir.
                mov     ecx,     0             ;
                int     0x80
        %endmacro

	;objetivo de la macro: toma el archivo previamiente abierto con macro "abreArchivo" y almacena su contenido en la variable de memoria del primer parametro
	;ejemplo de funcionamiento: leeArchivo variableEnMemoria
	;emeplo de uso: leeArchivo contenidoArchivo
	%macro leeArchivo 1 
		mov     edx,  128              ; numero de bytes a leer (uno por cada caracter).
        	mov     ecx,  %1               ; variable donde se almacena la información.
       	 	mov     ebx,  eax              ; mueve el archivo abierto a ebx.
        	mov     eax,  sys_read         ; invoca a sys_read (opción 3 de las interrupciones del kernel).
       		int     0x80
	%endmacro

	;objetivo de la macro: toma una variable en memoria y despliega su contenido
	;ejemplo de funcionamiento: despliegaContenidoArchivo variableEnMemoria
	;ejemplo de uso: despliegaContenidoArchivo contenidoArchivo
	%macro despliegaContenidoArchivo 1
		mov ecx, %1
	REPITA:
      		mov eax, 4
        	mov ebx, 1
       		mov edx, 1
        	int 80h

		inc ecx
		cmp cl,'0'
		jne REPITA 
	%endmacro

        ;objetivo de la macro: cierra un archivo previamente abierto
        ;ejemplo de funcionamiento: cierraArchivo variableMemoria
        ;ejemplo de uso: cierraArchivo nombreArchivo
	%macro cierraArchivo 1
        	mov eax,  sys_close            ; Invoca a SYS_clOSE (opción 6 de las interrupciones del Kernel).
		mov ebx,[%1]                   ; pasa el contenido de la variable de memoria hacia el registro ebx 
		int     0x80	
	%endmacro

        ;objetivo de la macro: transfiere el contenido de "entrada" hacia otra variable definida como parametro1, "entrada" debe ser un unico digito.
        ;ejemplo de funcionamiento: capturaASCII variableMemoria
        ;ejemplo de uso: capturaASCII otraEntrada
        %macro capturaASCII 1
                mov     eax , [entrada]        ; pasa el contenido en la variable de memoria "entrada" y la transfiere al registro eax
                mov     [%1],  eax             ; transfiere el contenido del registro eax hacia el contenido de la variable de memoria ingresada en el parametro uno
        %endmacro

        ;objetivo de la macro: transfiere el contenido de "entrada" hacia otra variable definida como parametro1, "entrada" debe ser un unico digito.
	;ejemplo de funcionamiento: capturaNumero variableMemoria
        ;ejemplo de uso: capturaNumero digitoNumerico
        %macro capturaNumero 1
                mov     eax, [entrada]         ; pasa el contenido en la variable de memoria "entrada" y la transfiere al registro eax quitando la parte ASCII
                sub     eax, 48                ; realiza la resta eax - 48 , la idea es obtener el valor numerico del valor de entrada y no su correspondiente ASCII
                mov     [%1], eax              ; transfiere el contenido del registro eax hacia el contenido de la variable de memoria ingresada en el parametro uno 
        %endmacro


        ;objetivo de la macro: sale del programa hacia la terminal
        ;ejemplo de funcionamiento: salir
        ;ejemplo de uso: salir
        %macro salir 0
                mov eax,1
		mov ebx,0
                int 80h
        %endmacro

	;objetivo de la macro: esta macro realiza una potenciacion, toma un numero en el primer parametro y lo eleva al segundo parametro
	;ejemplo de funcionamiento: potencia base valorInmediato valorInmediato
	;ejemplo de uso: potencia 2 3
        %macro potencia 2
                mov eax,%1
                mov ecx,%2
        ciclox:
                imul eax
                loop ciclox
        %endmacro

