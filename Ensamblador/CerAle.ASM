; Instituto Tecnologico de Costa Rica
; Fundamentos de organizacion de computadores
; Grupo 4
; Alejandro Cerdas Vargas
; Carne:2023073037
; Tarea: Asterix
; 1 de junio del 2023

; Manual de usuario:

; Para el correcto uso del programa se debe seguir cierta sintaxis que se explica a continuación:
; Si coloca "-T num R/V" se inserta un triángulo isósceles. Donde "num" es la altura del triángulo. Si coloca "-R num num R/V" se despliega un un rectángulo. El 
; el primer "num" recibido representa la altura y el segundo representa el ancho del rectángulo. Si coloca "-D num R/V" se despliega un rombo, donde el "num" recibido
; es el la altura del rombo. Si coloca "-E num R/V" se despliega un triángulo recto, el "num" recibido representa la altura del triángulo. Si introduce 
;"-Z num num R/V" se crea un trapecio, el primer "num" recibido representa el alto y el segundo representa la longitud de la base mayor. Si se coloca "-A num" se crea
; un asterisco gigante, el "num" recibido es el tamaño de cada brazo del asterisco. Si coloca "-P num" se crea una figura personalizada, en este programa se genera un 
; reloj de arena. El "num" recibido representa la altura del reloj. Finalmente, se se introduce "-H", se despliega una ayuda con información del uso del programa. 

; El "R/V" significa que si coloca "R", se desplegará una figura rellena y si es "V" una vacía. Si se irrespeta la sintaxis antes expuesta, se recibirá un mensaje de
; error. El programa soporta que el "num" se del 1 al 99. Tanto el trapecio como el reloj de arena tiene limitaciones. En el trapecio la diferencia entre la base 
; y la altura debe ser mayor a 4, de lo contrario se recibirá un mensaje de error. En el caso del reloj, la altura debe ser mayor a 6, de lo contrario se recibirá un
; mensaje de error. Tras el despliegue de la figura, en la parte inferior, se observará información hacer acerca de la Tarea.

; Análisis de resultados:

; En cuanto a la documentacion me calificaría con una A. En la bifurcacion principal una A. En la formacion de las distintas figuras una A. En cuanto a la salida
; de los datos una A. La figura personalizada una A. En el manejo de errores una A. En el uso del ensamblador una B, esto último porque considero que no utilice al 
; máximo las capacidades del ensamblador y en ocaciones el programa puede ser redudante. Creo que tal vez pude simplificar más el programa con el uso de más rutinas
; por ejemplo. En cuanto a la documentación interna una A.

 datos segment
    	
	rotulo db 128 dup ( ? )
	Fallo db "Error$"
	Acerca db "Instituto Tecnologico de Costa Rica--Fundamentos de Organizacion de computadores$"
	Acercaq db "Tarea Asterix--1 de junio del 2023--Alejandro Cerdas Vargas--Grupo 4$"
	Ayuda db "Para un uso correcto del programa, deje un espacio entre el nombre y despues coloque una de la siguientes opciones$"
	Ayuda1 db "-T num R o V => Despliega un triangulo isosceles, donde num es la altura$"
	Ayuda2 db "-R num num R o V => Despliega un rectangulo, recibe un alto y ancho$"
	Ayuda3 db "-D num R o V => Despliega un rombo, donde num es la altura$"
	Ayuda4 db "-E num R o V => Despliega un triangulo recto, donde num es la altura$"
	Ayuda5 db "-Z num R o V => Despliega un trapecio, recibe el alto y la base, entre la base y el alto debe haber al menos 7 de diferencia$"
	Ayuda6 db "-A num => Despliega un asterisco gigante, se recibe recibe el tamano del brazo$"
	Ayuda7 db "-P num => Despliega un reloj de arena, se recibe la altura, debe ser mayor a 6$"
	Ayuda8 db "-H => Sirve para desplegar este menu$"
	Ayuda9 db "En todos los casos los numeros pueden ser del 0 al 99 y si coloca R es una figura rellana y si es V vacia$"
	Alto dw ?
	Ancho dw ?
	exte dw ?
	inte dw 1
	
 datos ends
      
 pila segment stack 'stack'

    dw 256 dup (?)

 pila ends


codigo segment

    assume  cs:codigo, ds:datos, ss:pila                                                                            
          
inicio:   
	   mov ax, ds					; lo ponemos a apuntar al PSP
	   mov es, ax

	   mov ax, datos   
         mov ds, ax        
         mov ax, pila     				;Protocolo de inicio
         mov ss, ax
	 
	   mov si, 80h
         xor ch, ch                			; Se pone a apuntar al inicio de la pila       
         mov cl, byte ptr es:[si]
	    
	   dec cx						; Se busca eliminar el espacio en blanco entre el archivo y la entrada
	   inc si

	   xor di,di           				;Se colocar a apuntar al inicio de Rotulo

	   mov ah, 09h                            ; Se inserta la rutina para imprimir

ciclo:   inc si
         mov al, byte ptr es:[si]
         mov byte ptr rotulo[di], al  		; Pasamos todo al rotulo
         inc di
         loop ciclo
	   xor di, di
	   mov dl, byte ptr rotulo 			; Colocamos el primer lugar a dl y en 0 a dh
	   xor dh, dh

veri0:   cmp dl, "-" 					; comparamos al primer caracter de la entrada con la '-'
	   jne auxE
	   
	   call incdi 				; pasa a la segunda verificacion
	   cmp dl, 'T'                                   
	   je aux1

	   cmp dl, 'R'
	   je aux2

         cmp dl, 'D'
	   je aux3

	   cmp dl, 'E'
	   je aux4

	   cmp dl, 'Z'
	   je aux5

	   cmp dl, 'A'
	   je aux6

	   cmp dl, 'P'
	   je aux7

	   cmp dl, 'H'
	   jne auxe

	   mov ah, 09h            
	   lea dx, Ayuda 					; Imprime un menu de uso
         int 21h
	   call imcam
	   lea dx, Ayuda1				
         int 21h
	   call imcam
	   lea dx, Ayuda2				
         int 21h
	   call imcam
	   lea dx, Ayuda3				
         int 21h
	   call imcam
	   lea dx, Ayuda4 					
         int 21h
	   call imcam
	   lea dx, Ayuda5				
         int 21h
	   call imcam
	   lea dx, Ayuda6				
         int 21h
	   call imcam    
	   lea dx, Ayuda7				
         int 21h
	   call imcam
	   lea dx, Ayuda8				
         int 21h
	   call imcam
	   lea dx, Ayuda9				
         int 21h

	   jmp salir
	               			      

AuxE: jmp error
auxtr: jmp TR
aux1: jmp veri1
aux2: jmp veri2
aux3: jmp veri3               ; Se colocan auxiliares para no tener problema con los saltos
aux4: jmp veri4
aux5: jmp veri5 
aux6: jmp veri6
aux7: jmp veri7

					; Funcion que genera los triangulos isosceles
veri1:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '
	   jne auxe
	   
	   call incdi
	   call saca1		; Se coloca y convierte el primer numero de la entrada a alto
	   mov alto, bx
	   
	   call incdi           ; Si la siguiente cosa que sigue es un espacio en blanco saltamos 
	   cmp dl, ' '                             ; Si no, pasamos a una funcion para poder unirlos
	   jne SacarT
	   call incdi
	   jmp veriT

SacarT:  mov bx, alto
	   call saca2   		; Une los dos numeros de la entrada y los suma en alto para formar un numero de dos digitos
	   mov alto, bx   
	
	   call incdi
	   cmp dl, ' '          ; Verificamos que el dato que siga sea un espacio
	   jne auxe
	   call incdi
	   
veriT:  cmp dl, 'R'
	  je auxTR  
	  cmp dl, 'V'           ;Verificamos si la figura es rellena o no
	  jne auxe 
                               
	  mov ax, alto
	  mov exte, ax          ;Copiamos el valor de alto en el exte y lo reducimos 
	  dec exte
                              ; Funcion que genera el triangulo vacio
	  mov cx, exte          ;Se imprime la punta
cicTV:  call imbla              
	  loop cicTV         
	  call imste             

	  mov cx, exte
cic0TV: call imbla
	  loop cic0TV           ; Se imprimen los espacios 
	  dec exte                
  	  call imcam

	  mov cx, alto	  
cic1TV: push cx
	  cmp exte, 1           ;Se imprimen los primeros espacios en blanco
	  jb ctrl2TV            ;Se verifica que la sobra cuando llegue a 0 salga 
	  mov cx, exte
 cic2TV:call imbla
	  loop cic2TV
	  
	  call imste            ; Se coloca el asterisco del borde izquierdo
	  mov cx, inte
 cic3TV:call imbla            ; Se colocan los espacios dentro de la figura
	  loop cic3TV
	  call imste            ; Se coloca el asterisco del borde derecho

  	  mov cx, exte
  cic4TV:call imbla           ;Se colocan espacios fuera de la figura
	  loop cic4TV
	
	  call imcam
	  dec exte
	  inc inte              ;Se ajustan las variables para la siguiente linea
	  inc inte
	  pop cx
	  loop cic1TV

ctrl2TV:	  
	  xor ah, ah
	  mov al, 2             ; Se calculan los asteriscos que conforman la ultima linea
	  mul alto
	  mov alto, ax
	  dec alto              ; Se coloca la ultima fila de la figura
	  mov cx, alto
cic5TV: call imste
	  loop cic5TV 

	  jmp salir
 
TR:    mov ax, alto           ; Funcion que genera el triangulo relleno 
	  mov exte, ax          ; Se copia exte en alto
	  dec exte
        mov cx, alto          ; colocamos el alto como limite

cic1TR: push cx
	  cmp exte, 1           ; Verificamos que el exte sea menor a 1
	  jb ctrlTR
	  mov cx, exte     
 cic2TR:call imbla            ; Colocamos exte espacios en blanco
        loop cic2TR

   ctrlTR:mov cx, inte        ;Poner un nuevo contador
   cic3TR:call imste          ; Se imprime inte asteriscos
	  loop cic3TR
	  
        cmp exte, 1
	  jb salirT             ; Comparamos exte con 1 para saber si ya se termino la figura
	  mov cx, exte
   cic4TR:call imbla          ; Colocamos exte espacios en blanco
        loop cic4TR
	  pop cx
	  call imcam            ;Cambio linea
  
	  inc inte
       inc inte
	  dec exte              ;Se ajustan las variables
	  loop cic1TR
salirT: jmp salir

auxe1: jmp error              ; Etiqueta auxiliar
					
					; Funcion que genera los rectangulos
veri2:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '                             
	   jne auxe1
	   
	   call incdi           ; Se agrega el primer digito a la altura
	   call saca1
	   mov alto, bx

	   call incdi
	   cmp dl, ' '
	   jne sacarR1		;Se compara el siguiente caracter en busca de errores
	   call incdi
	   jmp sacarR2

	   
SacarR1: mov bx, alto
         call saca2		;Se unen el siguiente digito y el actual en alto
	   mov alto, bx
	   
         call incdi
         cmp dl, ' '          ; Hacemos una verificacion de sintaxis
	   jne auxe1
	   call incdi

 SacarR2:call saca1
	   mov ancho, bx		;Colocamos el siguiente digito en el ancho
	  
	   call incdi
	   cmp dl, ' '          ; Volvemos a verificar si sigue un numero o un espacio
	   jne sacarR3
	   call incdi
	   jmp sacarR4
	   
sacarR3: mov bx, ancho
	   call saca2		; Si es numero, lo unimos al que ya estaba en ancho
	   mov ancho, bx
                                            
	   call incdi
	   cmp dl, ' '
	   jne auxe2            ; Se verifica que siga un espacio en blanco y no se incumpla ningun error de sintaxis
	   call incdi
	   
sacarR4: cmp dl, 'R'
	   je RR                ; Se verifica si es rellena o no
	   cmp dl, 'V'
	   jne auxe2
                             
	   mov ax, ancho
	   mov inte, ax         ; Funcion que genera el rectangulo vacio
	   dec inte                
	   dec inte	   
ctrl1RV: mov cx, ancho        ;Se decrese el inte y se genera la primera linea y se disminuye el alto
cic1RV:  call imste
	   loop cic1RV          ; Se imprimen los asteiscos de las fila de arriba y abajo
	   call imcam
	   dec alto
	   cmp alto, 0
	   je auxs2
	   
	   mov cx, alto
cic2RV:  push cx
	   call imste           ; Se genera el asterisco de la izquierda de la linea
  	   mov cx, inte
  cic3RV:call imbla           ; Se imprimen los espacios en blanco dentro de la figura
	   loop cic3RV
	   call imste           ; Se genera el asterisco de la derecha de la linea                                         
	   call imcam
	   pop cx
	   dec alto
	   cmp alto, 1          ; Se verifica si queda solo una linea o si quedan mas
	   je ctrl1RV           ; Esto se hace para imprimir la linea de abajo
	   loop cic2RV

auxe2:   jmp error            ; Etiquetas auxiliares
auxs2:    jmp salir

RR:      mov cx, ancho        ;Funcion que crea el rectangulo relleno
cic1RR:  call imste
	   loop cic1RR          ; Se genran las lineas exteriores de la figura
	   call imcam
	   dec alto                                            
	   cmp alto, 0
	   je auxs2
	   
	   mov cx, alto
cic2RR:  push cx
  	   mov cx, ancho
  cic3RR:call imste           ; Se generan las lineas interiores de la figura
	   loop cic3RR   
	   call imcam
	   pop cx
	   dec alto             ; Se ajustan las variables
	   cmp alto, 1
	   je RR                ; Se usa el mismo codigo que con la figura vacia
	   loop cic2RR
	  	   	   
auxe3:   jmp error
auxs3:    jmp salir	      ; Etiquetas auxiliares
auxDR:   jmp DR

					; Funcion que genera los rombos
veri3:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '
	   jne auxe3
	   
	   call incdi
	   call saca1		; Se agarra el primer digitos y se inserta en el alto
	   mov alto, bx
	   
	   call incdi           ; Si la siguiente cosa que sigue es un espacio en blanco saltamos 
	   cmp dl, ' '                            
	   jne SacarD
	   call incdi
	   jmp veriD

SacarD:  mov bx, alto
	   call saca2		;Tomamos el siguiente digitos y lo unimos al que ya estaba en el alto
	   mov alto,bx

	   call incdi
	   cmp dl, ' '
	   jne auxe3            ; Se verifica que sigo un espacio y se respete la sintaxis
	   call incdi
	   
veriD:  cmp dl, 'R'
	  je auxDR 
	  cmp dl, 'V'           ; Se verifica si lo solicitado es relleno o vacio
	  jne auxe3
	  
	   mov ax, alto	      ; Funcion que crea el Rombo vacio
	   mov exte, ax         ;Se coloca el valor del alto en el exte y se decrese
	   dec exte
	   dec alto       	; Se decrese el alto dos veces para evitar que el ciclo coloque mas asteriscos de lo que deba
	   dec alto
	   mov cx, alto
	   
ctrl1DV: mov cx, exte      
cic1DV:  call imbla       	;Imprime la el asterisco de la punta
	   loop cic1DV      	; Se decrese exte para eliminar la primera fila     
	   call imste
	   call imcam
	   dec exte         
	   cmp inte, 0      	; Esta parte imprime las dos puntas del rombo, entonces aqui se verifica si se termino o no
	   jne ctrl2DV   
         jmp salir

ctrl2DV: mov cx, alto
cic2DV:  push cx
	   mov cx, exte      	;Este ciclo es el grande y genera el triangulo vacio
cic3DV:  call imbla        	; Se insertan los espacios del principio del rombo
	   loop cic3DV
	   call imste

	   mov cx, inte
cic4DV:  call imbla
	   loop cic4DV   		;Se insertan los espacios en blanco dentro del rombo
	   call imste
	   call imcam
	   
	   dec exte
	   inc inte
	   inc inte             ;Se ajustan las variables
	   pop cx
	   loop cic2DV

	   mov cx, inte
	   call imste
cic5DV:  call imbla        	;Este ciclo genera la linea que divide al romobo en dos
	   loop cic5DV
	   call imste
	   call imcam
	   
	   inc exte
	   dec inte 	      ; Se hace un ajuste para ingresar al nuevo ciclo
	   dec inte
	   mov cx, alto

cic6DV:  push cx
	   mov cx, exte
cic7DV:  call imbla           ; El ciclo genera el triangulo invertido
	   loop cic7DV          ; Se generan los espacios en blanco fuera del rombo
	   call imste
	   
	   mov cx, inte
cic8DV:  call imbla
	   loop cic8DV          ; Se generan los espacios en blanco dentro del rombo
	   call imste
	   call imcam
	   
	   dec inte
	   dec inte
	   inc exte             ; Se ajustan  variables
	   pop cx
	   loop cic6DV
	   mov inte, 0          ; Se cambia el inte a 0, se usa como bandera para indicar que se termino
	   jmp ctrl1DV

DR:      mov ax, alto         ;Funcion que genera el rombo relleno
	   mov exte, ax      	;Se coloca el valor del alto en el exte y se decrese
	   dec exte
	   
	   mov cx, alto
	   
cic1DR:  cmp exte, 0
	   je ctrl2DR
	   push cx              ;Primero se verifica si el exte llego a 0 para salir del ciclo y si no imprime exte espacios
	   mov cx, exte
cic2DR:  call imbla
	   loop cic2DR

ctrl1DR: mov cx, inte
cic3DR:  call imste           ;Imprime inte asteriscos
	   loop cic3DR
	   
	   call imcam
	   dec exte
	   inc inte
	   inc inte             ; Disminuye el exte, incremente al inte y hace cambio de linea
	   pop cx
	   loop cic1DR


ctrl2DR: mov cx, inte
cic4DR:  call imste           ; Genera la linea del medio del rombo
	   loop cic4DR
	   
	   inc exte
	   dec inte
	   dec inte             ; Se aumenta el exte, se le resta 2 al inte, se disminuye el alto, se hace un cambio de linea
	   dec alto
	   call imcam
	   mov cx, alto

cic5DR:  push cx
	   mov cx, exte
cic6DR:  call imbla           ; Se imprimen exte espacios
	   loop cic6DR
	   
	   mov cx, inte
cic7DR:  call imste
	   loop cic7DR          ; Se imprimen inte asteriscos
	   
	   call imcam
	   inc exte
	   dec inte
	   dec inte             ; Se hace un cambio de linea, decremena el inte dos veces y se incrementa el exte
	   pop cx 
	   loop cic5DR
	   
         jmp salir

auxs4: jmp salir              ; Etiquetas auxiliares
auxe4: jmp error
 
					; Funcion que crea los tiangulos rectangulos
veri4:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '
	   jne auxe4
	   
	   call incdi
	   call saca1		;Se toma el primer digito y se coloca en el alto
	   mov alto, bx
	   
	   call incdi           ; Si la siguiente cosa que sigue es un espacio en blanco saltamos 
	   cmp dl, ' '                            
	   jne SacarE           ; Si no significa que es un numero de dos digitos
	   call incdi
	   jmp veriE

SacarE:  mov bx, alto
	   call saca2		; Se toma el siguiente digito y se une alto
	   mov alto, bx

	   call incdi
	   cmp dl, ' '          ; Verificamos que no hayan errores de sintaxis
	   jne auxe4
	   call incdi
	   
veriE:  cmp dl, 'R'
	  je  ER                ; Se verifica si la figura es rellena o vacia
	  cmp dl, 'V'
	  jne auxe4
 
	  mov inte, 0           ; Funcion que imprime un triangulo rectangulo vacio
	  call imste
	  call imcam            ; Colocamos la punta del triangulo y hacemos un cambio de linea
	  dec alto
	  dec alto              ; Disminuimos el alto por la primera y ultima fila que son diferentes
        mov cx, alto          ; colocamos el alto como limite

cic1EV:  push cx
	   call imste
	   cmp inte, 0          ;Si el inte es 0 se imprimen dos asteriscos seguidos y un cambio de linea
	   je ctrl1EV                                

	   mov cx, inte
  cic2EV:call imbla 
	   loop cic2EV          ; Se imprimen inte espacios en blanco
ctrl1EV: call imste
	   call imcam           ; Se imprime el asterisco de la derecha seguido de un cambio de linea
	   inc inte
         pop cx
	   loop cic1EV
	   
	   inc alto
	   inc alto
	   mov cx, alto         ; se imprime la linea inferior
  cic3EV:call imste 
	   loop cic3EV          ; Se imprime asteriscos alto veces 
	   jmp salir


ER:     mov inte, 1       	; Funcion que imprime el triangulo rectangulo relleno
        mov cx, alto     	; colocamos el alto como limite
	   
cic1ER:  push cx
	   mov cx, inte
   cic2ER:call imste         	;Se imprimen los asteriscos de cada linea
	   loop cic2ER
	   inc inte         	; Imprimimos el triangulo recto aumentando el interior en cada ciclo 
	   call imcam
	   pop cx
	   loop cic1ER
	   jmp auxs4


auxe5: jmp error              ; Etiquetas auxiliares

					; Funcion que crea los trapecios
veri5:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '                             
	   jne auxe5
	   
	   call incdi           ; Se agrega el primer digito a la altura
	   call saca1
	   mov alto, bx

	   call incdi
	   cmp dl, ' '
	   jne sacarZ1		;Se realizan verificaciones de sintaxis y se busca ver si hay otro digito o no
	   call incdi
	   jmp sacarZ2

auxe05: jmp error
auxZR: jmp ZR                 ;Etiquetas auxiliares
	   
SacarZ1: mov bx, alto
	   call saca2		;Une el digito al que ya estaba en el alto
	   mov alto, bx		
	   
         call incdi
         cmp dl, ' '          ; Hacemos una verificacion de sintaxis
	   jne auxe5
	   call incdi


 SacarZ2:call saca1
	   mov ancho, bx		; Se toma el digito y se introduce en el ancho
	  
	   call incdi
	   cmp dl, ' '          ; Volvemos a verificar si sigue un numero o un espacio
	   jne sacarZ3
	   call incdi
	   jmp sacarZ4
	   
sacarZ3: mov bx, ancho
	   call saca2		; Se toma el digito y se suma al que se introdujo antes en ancho
	   mov ancho, bx 
                                           
	   call incdi
	   cmp dl, ' '
	   jne auxe05           ; Se verifica que siga un espacio en blanco y no se imcumpla ningun error de sintaxis
	   call incdi
	   
sacarZ4: cmp dl, 'R'
	   je auxZR             ; Se verifica si es rellena o no
	   cmp dl, 'V'
	   jne auxe05

         mov ax, ancho		; Funcion que genera un trapecio vacio
	   mov inte, ax		; Movemos el ancho al inte
	   dec alto
	   mov bx, alto
	   mov ax, 2
	   mul bx               ; Multiplicamos el alto reducido en uno y se lo restamos al ancho, asi se calcula la base menor
	   mov bx, ax
	   sub inte, bx
	   mov ax, alto
	   mov exte, ax
	   cmp inte, 4          ;Aqui buscamos observar si la diferencia no genera un trapecio
	   jb auxs5
	   
	   mov cx, exte         ; Funcion que genera el trapecio vacio
cic1ZV:  call imbla           ;Genera los espacios en blanco afuera de la figura
	   loop cic1ZV

ctrl1ZV: mov cx, inte
cic2ZV:  call imste	      ; Genera la linea superior
	   loop cic2ZV                                      
	   cmp exte, 0	      ; Si el exte es 0, significa que ya se formo la figura, esta misma funcion es usada para la linea 
	   je auxs5             ; inferior
	   
	   call imcam
	   dec exte             ; Se hace un cambio de linea y se elimina una fila
	   dec alto
	   
	   mov cx, alto
cic3ZV:  push cx
	   mov cx, exte         ;Se generan los espacios en blanco afuera de la figura
cic4ZV:  call imbla
	   loop cic4ZV
	   
	   call imste
	   mov cx, inte		; Genera el asterisco de la izquierda de la linea
cic5ZV:  call imbla           ; Genera los espacios dentro de la figura
	   loop cic5ZV
	   
	   call imste		; Genera el asterisco derecho de la linea
	   call imcam
	   dec exte
	   inc inte	            ; Se ajustan las variables
	   inc inte
	   pop cx
	   loop cic3ZV
	   mov ax, ancho
	   mov inte, ax
	   mov exte, 0          ;Aqui el codigo salta a generar la ultima linea en la funcion de arriba
	   jmp ctrl1ZV	      ; Se coloca el exte en 0 para indicar que ya se termino la figura

auxs5: jmp salir              ;Etiqueta auxiliar

ZR: 	   mov ax, ancho        ; Funcion que genera el trapecio relleno
	   mov inte, ax		;Movemos el ancho al inte
	   dec alto
	   mov bx, alto
	   mov ax, 2
	   mul bx			; Multiplicamos el alto, disminuido en uno, por dos
	   mov bx, ax
	   sub inte, bx		; El resultado de lo anterior se le resta al inte
	   mov ax, alto
	   mov exte, ax
	   cmp inte, 4		; Se busca observar si el se puede formar un trapecio con los valores entregados
	   jb auxe6
	   
	   mov cx, alto
cic1ZR:  push cx	
	   mov cx, exte         ;Se genera los espacios en blanco fuera de la figura
cic2ZR:  call imbla
	   loop cic2ZR
	   
	   mov cx, inte
cic3ZR:  call imste		; Se generan los asteriscos de la figura
	   loop cic3ZR
	   call imcam
	   
         dec exte
	   inc inte			; Se ajustan las variables para la siguiente linea
	   inc inte
	   pop cx
	   loop cic1ZR

	   mov cx, inte
cic4ZR:  call imste		; Se genera la ultima linea del trapecios
	   loop cic4ZR
	   jmp salir

auxe6: jmp error			; Etiquetas auxiliares
auxs6: jmp salir

veri6:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '
	   jne auxe6
	   
	   call incdi
	   call saca1		; Se toma el primer digito y se coloca el alto
	   mov alto, bx
	   
	   call incdi           ; Si la siguiente cosa que sigue es un espacio en blanco saltamos 
	   cmp dl, ''           ; Si no, pasamos a una funcion para poder unirlos
	   jne SacarA
	   jmp A

SacarA:  mov bx, alto
	   call saca2		;Se unen el digito con el numero que ya esta en alto
	   mov alto, bx

A:	   mov exte, 0 		; Funcion que genera el asterisco
	   mov ax, alto
	   mov inte, ax
	   dec inte	            ; Se decrementa el interior para ajustar el valor del tamaño del brazo
	   dec inte
	   mov ax, inte
	   mov ancho, ax	      ;Aqui usamos ancho para tener una variable fija para la cx, debido a que inte se modifica durante el programa
	   
	   mov cx, ancho
cic1A:   push cx
	   cmp exte, 0		; Buscamos si hay que insertar espacios en blanco o no
	   je ctrl1A
	   mov cx, exte
cic2A:   call imbla		;Se insertan los espacios en blanco
	   loop cic2A
	   
ctrl1A:  call imste		; Se coloca el asterisco de la izquierda
	   mov cx, 2		; Colocamos el 2, para realizar un ciclo de insertar espacios en blanco dentro de la figura dos veces		
		
cic3A:   push cx
	   mov cx, inte 
cic4A:   call imbla		; inserta los espacios en blanco dentro de la figura
	   loop cic4A
	   call imste           ; Genera el asterisco del centro en la primera vuelta, despues genera el asterisco de afuera
	   pop cx
	   loop cic3A

	   call imcam
	   dec inte
	   inc exte			; Se ajustan las variables para la siguiente vuelta
         pop cx
	   loop cic1A
	   
	   call imtas		; Genera tres asteriscos a cierta distancia

	   mov ax, 2
	   mul alto
	   mov alto, ax		; Se calcula cuantos asteriscos son en la linea del centro
	   dec alto
	   mov cx, alto
cic6A:   call imste		; Se insertan los asteriscos
	   loop cic6A
	  
	   call imcam		; Cambio de linea
	   call imtas		; Se insertan tres asteriscos
	   mov inte, 1 		; Para colocar la parte inferior, es necesario que el interior, que termino en 0 en el ciclo pasado, sea 1
	   dec exte			; Se decrementa exte para evitar que coloque mas lineas de las que deba   			

	   mov cx, ancho
cic7A:   push cx
	   cmp exte, 0		; Si exte es 0 no es necesario colocar espacios en blanco entonces se lo salta
	   je ctrl2A
	   mov cx, exte
cic8A:   call imbla		; Genera los espacios en blanco
	   loop cic8A
	   
ctrl2A:  call imste		; Coloca el asterisco de la izquierda
	   mov cx, 2		; Se busca hacer esta parte del ciclo dos veces 
cic9A:   push cx
	   mov cx, inte 
cic10A:  call imbla		; Coloca los espacios dentro de la figura
	   loop cic10A
	   call imste		; Primero genera el asterisco del centro y despues el de la derecha
	   pop cx
	   loop cic9A

	   call imcam		; Se hace un cambio de linea
	   dec exte
	   inc inte			; Se ajustan las variables, pero esta vex aumentando inte y decrementado exte
         pop cx
	   loop cic7A
	   jmp salir

auxe7: jmp error
					; Funcion que genera una reloj de arena
veri7:   call incdi           ; pasamos al siguiente caracter y a la siguiente validacion
	   cmp dl, ' '
	   jne auxe7
	   
	   call incdi
	   call saca1		;Se toma el digito y se coloca en el alto
	   mov alto, bx
	   
	   call incdi           ; Si la siguiente cosa que sigue es un espacio en blanco saltamos 
	   cmp dl, ''           ; Si no, pasamos a una funcion para poder unirlos
	   jne SacarP
	   jmp P

SacarP:  mov bx, alto
	   call saca2   		; Une los dos numeros de la entrada
	   mov alto, bx
	   				;Funcion que genera un reloj de arena
P:	   cmp alto, 6		; Si el alto es menor a 6 se considera un error
	   jb auxe7
	   mov exte, 1		; Se coloca el exte en 1
	   mov bx, alto
	   mov ax, 2
	   mul bx			; Multiplicamos la altura por 2, despues la decresemos y lo colocamos en ancho
	   dec ax
	   mov ancho, ax		; Ancho en esta funcion es usado como un auxiliar para saber el tamaño de la linea superior e inferior
	   mov inte, ax
	   sub inte, 4		; inte lleva el mismo valor pero reducido 4 veces
	
ctrl3P:  mov cx, ancho
cic1P:   call imste		;Imprime la linea superior e inferior 
	   loop cic1P		
	   cmp exte, 0		; Si el exte es 0, significa que la figura ya se acabo
	   jne ctrl4P
  	   jmp salir
					; Inserta el triangulo mirando abajo
ctrl4P:  dec alto			; Se elimina la linea antes insertada
	   call imcam		; Cambio de linea
	  	
	   mov cx, 2		; Solo se hace el ciclo 2 veces
cic2P:   push cx
	   mov cx, exte
cic3P:   call  imbla		; Se insertan las segunda y tercera linea con espacios 
	   loop cic3P
	   call imste		; Se inserta asterisco

	   mov cx, inte
cic4P:   call imbla		; Se insertan los espacios
	   loop cic4P
	   call imste		; Se inserta los asteriscos
	   call imcam		; Se hace un cambio de linea
	   dec inte
	   dec inte			; Se ajustan las variables
	   inc exte	
	   pop cx
	   loop cic2P

	   dec alto
	   dec alto
	   dec alto			; Se modifica el alto y el inte
	   inc inte
	   inc inte
	   
	   mov cx, alto
cic5P:   push cx
	   mov cx, exte
cic6P:   call imbla		; Coloca alto espacios 
	   loop cic6P

	   mov cx, inte
cic7P:   call imste		; Se colocan los asteriscos		
	   loop cic7P
	   call imcam		; Cambio de linea
	   dec inte
	   dec inte			; Se ajustan variables
	   inc exte
	   pop cx
	   loop cic5P 

	   mov cx, exte
cic8P:   call imbla 		; Coloca los espacios fuera de la figura
	   loop cic8P
	   call imste		; Coloca el asterisco y hace un cambio de linea
	   call imcam
	    
	   dec exte
	   mov ax, exte		; Se colocan las variables para poder crear el triagulo hacia arriba con una linea en el centro
	   mov alto, ax
	   mov inte, 0		; Para colocar la parte inferior, es necesario que el inte sea 0
	   
	   mov cx, alto
cic9P:   push cx
	   cmp inte, 0		; Verificamos que si el interior es 0, coloque tres asteriscos
	   je ctrl1P
	   mov cx, exte
cic10P:   call imbla		; Genera los espacios en blanco
	   loop cic10P
	   
         call imste		; Coloca el asterisco de la izquierda
	   mov cx, 2		; Se busca hacer esta parte del ciclo dos veces 
cic11P:   push cx
	   mov cx, inte 
cic12P:  call imbla		; Coloca los espacios dentro de la figura
	   loop cic12P
	   call imste		; Primero genera el asterisco del centro y despues el de la derecha
	   pop cx
	   loop cic11P

	   call imcam		; Se hace un cambio de linea
ctrl2P:  dec exte
	   inc inte			; Se ajustan las variables
         pop cx
	   loop cic9P
	   mov exte, 0		; Se coloca el exte para saber que la figura ya se acabo
	   jmp ctrl3P
	   
ctrl1P:  call imtas
	   jmp ctrl2p		;Inserta tres asteriscos

        
imcam proc near         	; Imprime cambios de linea
	   
	   push ax 		      ; Guarda los registros
	   push dx
	   mov ah, 02h
	   mov dl, 10       	; cambio de linea
         int 21h
         mov dl, 13       	; cambio de linea
         int 21h		 
         pop dx
	   pop ax           	; Saca los registros 
	   ret
	
imcam endP
	
imbla proc near
 	   
	  push dx             	; Se guardan los registros
	  push ax
	
        mov ah, 02h       	; Rutina para imprimir	
	   mov dl, 32        	;Espacio en blanco
        int 21h

	  pop ax 	            ;Se sacan los registros
	  pop dx
	  ret

imbla endP

imste proc near
 	   
	  push dx    	      ; Se guardan los registros
	  push ax
	
        mov ah, 02h     	; Rutina para imprimir	
	   mov dl, 42        	; codigo ascci del asterisco
        int 21h
	  
	  pop ax          	; Se saca los registros
	  pop dx
	  ret

imste endP

imTas proc near	            ;Genera tres asteriscos a exte distancia

	   mov cx, exte
cic5A:   call imbla           ;Primero genera los espacios de distancias
	   loop cic5A
	   call imste
	   call imste  
	   call imste		; Genera los asteriscos
	   call imcam	      ; Cambio de linea
	   ret

imtas endP

saca1 proc near

	xor dh, dh                          
	mov bx, dx			;Toma el numero de dl y le quita 30h, convirtiendolo en un numero decimal
	sub bx, 30h
	ret

saca1 endP

saca2 proc near
	
	push dx
	mov al, 10			; Toma al numero actual en bx, lo multiplica por 10 y se le suma el dl
	xor ah, ah                              
	mul bx                               
	mov bx, ax
	pop dx
	xor dh, dh
	sub dl, 30h
      add bx, dx
	xor dx, dx
	ret

saca2 endP

incdi proc near

 	inc di			; Incrementa el indice
	mov dl, byte ptr rotulo [di]	
	ret

incdi endP

Error:   call imcam           ; Se hace un cambio de linea
	   mov ah, 09h
         lea dx, Fallo 		; Imprime un mensaje de error
         int 21h
	   

salir:                     				
         call imcam           ; Se hace un cambio de linea
	   mov ah, 09h
	   lea dx, Acerca
	   int 21h
	   call imcam 		; Imprime un mensaje de Acerca
         lea dx, Acercaq 	 				
         int 21h

	   mov ax, 4C00h
         int 21h              ; Sale del programa
 
codigo ends
end inicio

