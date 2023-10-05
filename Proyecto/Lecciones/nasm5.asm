
extern printf

section .data
   msg1: db "",0xA,0xD,0

section .text
    global _start

_start:
   mov ecx,msg1 


   mov eax,'a'
   mov ebx,'b'
   mov edx,'d'
   
   push eax
   push rbx
   push rdx

   pop rax
   pop rbx
   pop rdx 


   ; Esta interrupcion con los valores de los registros imprime en pantalla el mensaje
   mov [msg1],rax
   mov ecx,msg1
   mov eax, 4
   mov ebx, 1
   mov edx,3
   int 80h


   ; Esta interrupcion con los valores de los registros imprime en pantalla el mensaje
   mov [msg1],rax
   mov ecx,msg1
   mov eax, 4
   mov ebx, 1
   mov edx,1
   int 80h


salir:    
   ; Esta interrupcion con los valores de los registros permite salirse del programa
    mov eax, 1
    mov ebx, 0
    int 80h


