;==================================================================
;PROGRAMA QUE UTILIZA UN LOOP PARA IMPRIMIR UN MENSAJE
;RESTAURANDO EL VALOR DEL REGISTRO ECX EN LA PILA (STACK) 
;==================================================================

section .data

	msg: db 'Hola',10,13

section .text                                                                  
	global _start                                                                        

_start:                                                                        

	;El ciclo se repetira 9 veces
	mov ecx, 9
	
REPITA:
	push rcx
		
	; Esta interrupcion con los valores de los registros imprime en pantalla el mensaje
	mov eax, 4
	mov ebx, 1
	mov ecx,msg
	mov edx,6
	int 80h

	pop rcx
	loop REPITA

	; Esta interrupcion con los valores de los registros permite salirse del programa
	mov eax, 1
	mov ebx, 0
	int 80h


