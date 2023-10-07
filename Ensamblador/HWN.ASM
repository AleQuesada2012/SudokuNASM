 ; Este es el programa de Repeticiones de saludo

datos segment

  Msg  db "Hello World!!!$"
  N    dw 4 

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

      mov cx, N  
ciclo: int 21h
      loop ciclo

      mov ax, 4C00h   ; Protocolo de finalización del programa
      int 21h 

codigo ends

end main