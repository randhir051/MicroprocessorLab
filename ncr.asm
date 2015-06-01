.model small
.data
	n dw 07
	r dw 04
	res dw 00h

.code
	mov ax,@data
	mov ds,ax
	call ncr
	mov ax,res
	mov ah,00h
	mov bx,10d		;to indicate bottom of stack
	push bx
	conv: 
		mov dx,00h
		div bx
		push dx
		cmp ax,00h
		jne conv	; repeat until ax becomes zero

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

	ncr proc near
		cmp r,00h
		jnz l1
		add res,01h
		ret

		l1:
			mov ax,n
			cmp ax,r
			jnz l2
			add res,01h
			ret

		l2:
			cmp r,1
			jnz l3
			mov ax,n
			add res,ax
			ret

		l3:
			dec n
			mov ax,n
			cmp r,ax
			jnz l4
			add res,ax
			inc res
			ret

		l4:
			push n
			push r
			call ncr
			pop r
			pop n
			dec r
			push n
			push r
			call ncr
			pop r
			pop n
			ret
	ncr endp
end