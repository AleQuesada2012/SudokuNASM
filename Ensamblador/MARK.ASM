; Este programa de ASM lo que hace es imprimir un markito
; recibe dos dígitos de la línea de comandos.  Ancho y Alto

 datos segment

    rotulo db 128 dup ( ? )

    Ancho dw ?
    Alto  dw ?

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


         mov al, byte ptr rotulo 
         sub al, 30h
         xor ah, ah
         mov ancho, ax
         mov al, byte ptr rotulo+1 
         sub al, 30h
         xor ah, ah
         mov alto, ax

         mov ah, 02h
         mov dl, 201       ; esquina superior izquierda
         int 21h

         mov cx, ancho     ; linea superior
         mov dl, 205       ; caracter de la linea horizontal
cic1:    int 21h 
         loop cic1

         mov dl, 187       ; esquina superior derecha
         int 21h

         mov dl, 10       ; cambio de linea
         int 21h
         mov dl, 13       ; cambio de linea
         int 21h

         mov cx, Alto
cic2:
         

         push cx        
         mov cx, Ancho 
         mov dl, 32       ; espacio en blanco
   cic3: int 21h
         loop cic3
         pop cx

         mov dl, 186       ; linea vertical
         int 21h
         mov dl, 10       ; cambio de linea
         int 21h
         mov dl, 13       ; cambio de linea
         int 21h
         loop cic2

         mov dl, 200       ; esquina inferior izquierda
         int 21h

         mov cx, ancho     ; linea superior
         mov dl, 205       ; caracter de la linea horizontal
cic4:    int 21h 
         loop cic4

         mov dl, 188       ; esquina inferior derecha
         int 21h


      
         mov ax, 4C00h
         int 21h

     
 codigo ends

 end inicio
