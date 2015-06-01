.model small

print macro char
	mov dl,char
	mov ah,02h
	int 21h
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

terminate macro
	mov ah,4ch
	int 21h
endm

newline macro
	print 0ah
	print 0dh
endm

.data
	str db 50 dup('$')
	msgRead db 0ah,0dh,"Enter a String less than 50 characters: $"
	msgPrint db 0ah,0dh,"The output string is: $"

.code
	mov ax,@data
	mov ds,ax
	printf msgRead
	mov cx,49
	lea si,str

	reading: 
		read
		cmp al,0dh
		je printing
		mov [si],al
		inc si
		jmp reading

	printing:
		newline
		printf msgPrint
		printf str

	terminate
end