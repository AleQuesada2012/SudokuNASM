segment .bss 
 
    aleatorio resb 1    ; variable que almacenara el numero aleatorio 
 
section .text 
 
global _start 
 
_start: 
 
     
    rdtsc ;The rdtsc (Read Time-Stamp Counter) instruction is used to determine how many CPU ticks took place since the processor was reset. 
    and ah, 00000111b  ;hace un and para obtener numeros del 0 al 7 
    add ah,'0'     ; convierte valor numero en su equivalente ASCII para despliegue 
    mov [aleatorio],ah ; almacena en "aleatorio" el numero obtenido 
   
   ;Interrupcion de despliegue de numero aleatorio 
    mov     edx,1                           
    mov     ecx,aleatorio                   
    mov     ebx,1                           
    mov     eax,4                           
    int     80h                                       
 
    mov     eax, 1 
    int     0x80
