.model small

print macro num
	mov dl,num
	add dl,30h
	mov ah,02h
	int 21h
endm

.data
	array db 05h,03h,04h,01h,02h
	len dw $-array

.code
	mov ax,@data
	mov ds,ax
	mov bx,len
	dec bx

	outerLoop:
		mov cx,bx	;innerLoop runs on counter(CX)
		lea si,array
		innerLoop:
			mov al,[si]
			inc si
			cmp al,[si]
			jbe noswap		;dont swap if the current element <= next
			xchg al,[si]	;otherwise do the swapping
			mov [si-1],al
			noswap: loop innerLoop	;will run by default after swapping
		dec bx
		jnz outerLoop	;loop until BX becomes zero

	print array[0]
	print array[1]
	print array[2]
	print array[3]
	print array[4]

	mov ah,4ch
	int 21h
end