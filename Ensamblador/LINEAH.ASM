; Este programa de ASM lo que hace es imprimir una línea horizontal 
; recibe un dígito de la línea de comandos.

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


         mov cl, byte ptr rotulo 
         sub cl, 30h
         xor ch, ch

         mov ah, 02h
         mov dl, 42  ; ascii del asterisco 
ciclo2:  int 21h
         loop ciclo2



         mov ax, 4C00h
         int 21h

     
 codigo ends

 end inicio
