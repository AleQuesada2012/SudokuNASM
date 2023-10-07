; Este es el programa de ejemplo de saltos de conejo

datos segment
    X dw ?  
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

      xor ax, ax
      cmp al, 5

      ; je xxx      ; salto condicional que da el error de fuera de rango
       
;     je aux1       ; primera solucion
;     jmp aux2
; aux1: jmp xxx
; aux2:  

      jne aux1      ; segunda solucion
      jmp xxx
 aux1: 

      mov ax, 4
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
   
xxx:
      mov ax, 4C00h   ; Protocolo de finalización del programa
      int 21h 

codigo ends

end main