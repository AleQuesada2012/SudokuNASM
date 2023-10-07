; Este es el programa de Hola Mundo!

datos segment

  Msg  db "Hola Mundo!!!$"

datos endS

pila segment stack 'stack'
   dw 256 dup(?)
pila endS



codigo segment
   Assume CS:codigo, DS:datos, SS:pila

main: mov ax, pila    ; protocolo de inicio del programa
      mov ss, ax      ; pone al DS a apuntar al segmento de Datos
      mov ax, datos   ; y pone al SS a apuntar al segmento de Pila
      mov ds, ax
   
      mov ah, 09h
      lea dx, msg 
      int 21h

      mov ax, 4C00h   ; Protocolo de finalización del programa
      int 21h 

codigo ends

end main