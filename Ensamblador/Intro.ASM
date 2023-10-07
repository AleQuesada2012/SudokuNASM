; Este programa de ASM lo que hace es imprimir un markito
; recibe dos dígitos de la línea de comandos.  Ancho y Alto

 datos segment

    rotulo db 128 dup ( ? )

    exte  dw ?		; Significa los espacios que van en blanco
    Alto  dw ?		
    inte  dw 1 		; Significa los lugares que van con asteriscos
    ancho dw ?

 datos ends

                  
 pila segment stack 'stack'

    dw 256 dup (?)

 pila ends


codigo segment

    assume  cs:codigo, ds:datos, ss:pila

                                                                             
 inicio: mov ax, ds    ; ponemos al ES a apuntar al inicio del PSP
         mov es, ax

         mov ax, datos  ; El DS que apuntaba al PSP se debe poner a apuntar al segmento de datos para 
         mov ds, ax     ; poder usar las variables.

         mov ax, pila
         mov ss, ax

         mov si, 80h
         xor ch, ch     ; le movemos 0 al ch            
         mov cl, byte ptr es:[si]

         dec cx
         inc si

         xor di, di    ; se pone a 0 para apuntar al inicio de la variable rotulo

ciclo:   inc si
         mov al, byte ptr es:[si]
         mov byte ptr rotulo[di], al
         inc di

         loop ciclo

	   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '
	   jne auxe
	   
	   call saca1
	   mov alto, bx
	   
	   call incdi            ; Si la siguiente cosa que sigue es un espacio en blanco saltamos 
	   cmp dl, ' '                             ; Si no, pasamos a una funcion para poder unirlos
	   jne SacarT
	   call incdi
	   jmp veriT

SacarT:  mov bx, alto
	   call saca2   
	   mov alto, bx   
	
	   call incdi
	   cmp dl, ' '                                ; Verificamos que el dato que siga sea un espacio
	   jne auxe
	   call incdi
	   
veriT:  cmp dl, 'R'
	  je auxTR  
	  cmp dl, 'V'                   ;Verificamos si la figura es rellena o no
	  jne auxe     

	   	   
saca1 proc near
	inc di
	mov dl, byte ptr rotulo [di]
	xor dh, dh                          
	mov bx, dx
	sub bx, 30h
	ret

saca1 endP

saca2 proc near

	push dx
	mov al, 10
	xor ah, ah                              
	mul bx                               
	mov bx, ax
	pop dx
	xor dh, dh
	sub dl, 30h
      add bx, dx
	ret

saca2 endP

incdi proc near
 	inc di
	mov dl, byte ptr rotulo [di]	
	ret
incdi endP

imTas proc near

	   mov cx, exte
cic5A:   call imbla
	   loop cic5A
	   call imste
	   call imste
	   call imste
	   call imcam
	   ret
imtas endP
	   	    
imcam proc near         ; Imprime cambios de linea
	   
	   push ax          ; Guarda los registros
	   push dx
	   mov ah, 02h
	   mov dl, 10       ; cambio de linea
         int 21h
         mov dl, 13       ; cambio de linea
         int 21h		 
         pop dx
	   pop ax           ; Saca los registros 
	   ret
	
imcam endP
	
imbla proc near
 	   
	  push dx
	  push ax
	
        mov ah, 02h       ; Rutina para imprimir	
	   mov dl, 32        ;Espacio en blanco
        int 21h

	  pop ax
	  pop dx
	  ret

imbla endP

imste proc near
 	   
	  push dx
	  push ax
	
        mov ah, 02h       ; Rutina para imprimir	
	   mov dl, 42        ;asterisco
        int 21h
	  
	  pop ax
	  pop dx
	  ret

imste endP

salir:  mov ax, 4C00h
        int 21h

     
 codigo ends

 end inicio
