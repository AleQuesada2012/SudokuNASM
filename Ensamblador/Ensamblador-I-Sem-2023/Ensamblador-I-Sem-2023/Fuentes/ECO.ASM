 ; Este programa de ASM lo que hace es repetir un eco de lo que se le diga en la línea de comandos.

 datos segment

    rotulo db 128 dup ( ? )
    N dw 7                                                       

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
         xor ch, ch              
         mov cl, byte ptr es:[si]

         dec cx
         inc si

         xor di, di

ciclo:   inc si
         mov al, byte ptr es:[si]
         mov byte ptr rotulo[di], al
         inc di

         loop ciclo


         mov byte ptr rotulo[di], 0Dh
         inc di
         mov byte ptr rotulo[di], 0Ah
         inc di
         mov byte ptr rotulo[di],'$'

         mov cx, N

         mov ah,09h
         lea dx, rotulo
 ciclo2: int 21h
         loop ciclo2

         mov ax, 4C00h
         int 21h

     
 codigo ends

 end inicio
