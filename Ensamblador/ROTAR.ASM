; Este es el programa rota un rotulo

datos segment

  Msg  db "Hello World!!!.",10,13,'$'
  N    db 8 

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

      lea si, Msg

      mov cl, N
ciclo: cmp byte ptr [si],'.'
      je salir
      rol byte ptr [si], cl
      inc si
      jmp ciclo
salir:
      mov ah, 09h
      lea dx, msg
      int 21h


      mov ax, 4C00h   ; Protocolo de finalización del programa
      int 21h 

codigo ends

end main