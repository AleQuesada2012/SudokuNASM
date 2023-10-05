%macro imprimeEnPantalla 2
                mov     eax, sys_write          		; opción 4 de las interrupciones del kernel.
                mov     ebx, stdout            			; standar output.
                mov     ecx, %1                 		; mensaje.
                mov     edx, %2                 		; longitud.
                int     0x80
%endmacro


section .data                                   		; Segmento de Datos
	origen		db 'Simulando Espera...',10,13,0     	; Declaro una variable origen que tiene la palabra precargada
	longitudOrigen  equ $-origen				; Determino longitudOrigen	
	tiempoTotal     dd      120	
        sys_write       EQU     4
        stdout          EQU     1	

section .bss                                   			 ; Segmento de Datos no inicializados
	tiempo1 	resd 1                 			 ; Variable tiempo1 para almacenar el primer tiempo
	tiempo2		resd 1					 ; Variable tiempo2 para almacenar el segundo tiempo

section .text                                   		; Segmento de Codigo
   global _start                                		; Inicio del Segmento de Codigo

_start:                                         		; Punto de entrada del programa
	xor rcx,rcx						; Limpia registro ecx
	xor rdx,rdx						; Limpia registro edx
	xor rax,rax						; Limpia registro eax

	mov  eax, 13       					;Interrupcion que toma el primer tiempo EPOCH 
	xor rbx,rbx
	int  0x80

	mov dword [tiempo1],eax					;Almacena la cantidad de segundos desde el primer tiempo EPOCH en variable tiempo1

;Comienza aca: Codigo que se puede omitir porque es de prueba

	push rdx						
	mov ecx,1
CICLO:
	push rcx
	imprimeEnPantalla origen,longitudOrigen
	pop rcx
	LOOP CICLO		
	pop rdx

;Termina aca: Codigo que se puede omitir porque es de prueba

        mov  eax, 13						;Interrupcion que toma el segundo tiempo EPOCH
	xor rbx,rbx
        int  0x80


	mov dword [tiempo2],eax					;Almacena la cantidad de segundos desde el segundo tiempo EPOCH en variable tiempo2

        xor rcx,rcx                                             ; Limpia registro ecx
        xor rdx,rdx                                             ; Limpia registro edx
        xor rax,rax                                             ; Limpia registro eax

	mov ebx,dword [tiempo1]					;Se asigna ebx=tiempo1	
	mov eax,dword [tiempo2]					;Se asigna eax=tiempo2
	mov cl,byte [tiempoTotal]				;cl=120 (cantidad de 120s)
	sub eax,ebx						;Obtiene el delta en segundos (tiempo2-tiempo1)
	sub ecx,eax						;Resta 120 - (tiempo2-tiempo1)

								;el registro ECX es el que tiene el tiempo en segundos, por lo tanto es el que se utilizara
								;para determinar si pasaron los 120s o no								


	;Salir a la terminal
        mov eax,1
        mov ebx,0
        int 80h
	
