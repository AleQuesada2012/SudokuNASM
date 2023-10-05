%include 'macros.asm'

section .bss

matrix: resd 3*3
entrada: resb 8
digito:  resq 1  ; Change to resq to store a 64-bit integer

section .data

stdout equ 1
stdin  equ 0
sys_write equ 1
sys_read  equ 0

mensaje: db "Inserte un número: ", 0, 0
longitud: equ $-mensaje

format db "Ingresado: %d", 10, 0

section .text
extern printf

global main

main:
    imprimeEnPantalla mensaje, longitud
    leeTeclado
    capturaNumero digito  ; Capture a numeric value into 'digito'
    mov rdi, format
    mov rax, [digito]       ; Load the value from 'digito'
    call printf
    salir
