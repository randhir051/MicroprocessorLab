.model small

setcursor macro		;sets the cursor in the middle of screen
	mov dh,12d		;Y co-ordinate
	mov dl,39d		;X co-ordinate
	mov bh,0		;attribute
	mov ah,02h
	int 10h
endm

clrscr macro
	mov bh,07h		;blinking cursor attribute
	mov cx,00h
	mov dh,24d
	mov dl,79
	mov ah,06h
	int 10h
endm

printf macro msg
	lea dx,msg
	mov ah,09h
	int 21h
endm

read macro	
	mov ah,01h
	int 21h
endm


.data
	msgRead db 0ah,0dh,"Enter a Character: $"

.code
	mov ax,@data
	mov ds,ax
	clrscr
	printf msgRead
	read
	mov ah,00h
	mov bx,10d		;to indicate bottom of stack
	push bx
	conv: 
		mov dx,00h
		div bx
		push dx
		cmp ax,00h
		jne conv	; repeat until ax becomes zero

	setcursor

	printing:
		pop dx
		cmp dx,10d
		je exit		;exit if bottom of stack is hit
		add dl,30h
		mov ah,02h
		int 21h
		jmp printing

	exit:
		mov ah,4ch
		int 21h

end



