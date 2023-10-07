; Este programa averigua cual es el mayor de dos números y lo despliega.

datos segment

  X  db 200
  Y  db 5

  Base dw 10
  
datos endS

pila segment stack 'stack'
   dw 256 dup(?)
pila endS



codigo segment
   Assume CS:codigo, DS:datos, SS:pila

printAX proc near    
; imprime a la salida estándar un número que supone estar en el AX
; supone que es un número positivo y natural en 16 bits.
; lo imprime en la base que indica la variable Base del Data Segment.  
    
    push AX
    push BX
    push CX                           
    push DX

    xor cx, cx
    mov bx, Base
ciclo1PAX: xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne ciclo1PAX
    mov ah, 02h
ciclo2PAX: pop DX
    add dl, 30h
    cmp dl, 39h
    jbe prnPAX
    add dl, 7
prnPAX: int 21h
    loop ciclo2PAX 

    pop DX
    pop CX
    pop BX
    pop AX
    ret
printAX endP

CamLin Proc
   push ax
   push dx
   mov dl, 13
   mov ah, 02h
   int 21h
   mov dl, 10
   int 21h
   pop dx
   pop ax
   ret
CamLin EndP


main: mov ax, pila    ; protocolo de inicio del programa
      mov ss, ax      ; pone al DS a apuntar al segmento de Datos
      mov ax, datos   ; y pone al SS a apuntar al segmento de Pila
      mov ds, ax

      mov al, X
      cmp al, Y         ; por dentro lo que hace es una resta
      ja mayor          ; usamos ja en lugar de jg para trabajar con números naturales
      mov al, Y
mayor: xor ah, ah        ; mueve 0 al ah     
      call printax

      mov ax, 4C00h   ; Protocolo de finalización del programa
      int 21h 

codigo ends

end main