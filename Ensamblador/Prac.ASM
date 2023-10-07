datos segment
	
     rotulo db 128 dup (?)
     N dw 4
	
datos ends
	
pila segment stack 'stack'
     
     dw 256 dup (?)

pila ends
	

codigo segment

	assume cs:codigo, ss:pila, ds:datos

inicio:
	
	mov ax, ds
	mov es, ax
	
	mov ax, datos
	mov ds, ax
	mov ax, pila
	mov ss, ax
	
	mov si, 80h
	xor ch, ch	
	mov cl, byte ptr es:[si]
	
	dec cx
	inc si
	xor di, di
	xor ah, ah

ciclo:  inc si
	mov al, byte ptr es:[si]
	mov byte ptr rotulo[di], al
	inc di
	loop ciclo
	
	
	xor bx, bx
	mov ax, 1

ciclo1: cmp ax, N
	jb impri
	add bx, ax
	inc ax
	jmp ciclo1
	
Impri:  add bx, 30h
	;cmp bx, 39h
	;jb salto
	;add bx, 7

salto:	mov ah, 02h
	mov dx, bx
	int 21h

salir:  mov ax, 4C00h
	int 21h

codigo ends

end inicio

	
	
	
	