.model small

print macro char
	mov dl,char
	add dl,30h
	mov ah,02h
	int 21h
endm

printf macro msg
	lea dx,msg
	mov ah,09h
	int 21h
endm

scanf macro msg
	lea dx,msg
	mov ah,0ah
	int 21h
endm

clrscr macro
	mov bh,07h
	mov cx,00h
	mov dh,24d
	mov dl,79
	mov ah,06h
	int 10h
endm

.data
	buf1 db 09
	l1 db ?
	X db 09 dup(?)

	buf2 db 09
	l2 db ?
	Y db 09 dup (?)

	enter1 db 0ah,0dh,"Enter string one: $"
	enter2 db 0ah,0dh,"Enter string two: $"
	equalstr db 0ah,0dh,"Given strings are equal: $"
	unequalstr db 0ah,0dh,"Given strings are NOT equal$"
	length1 db 0ah,0dh,"Length of string one: $"
	length2 db 0ah,0dh,"Length of string two: $"

.code
	mov ax,@data
	mov ds,ax
	mov es,ax

	printf enter1
	scanf buf1

	printf enter2
	scanf buf2

	mov al,l1
	cmp al,l2
	jne notEqual	

	checkEquality:
		lea si,X
		lea di,Y
		mov cl,l1
		mov ch,00h
		cld
		repe cmpsb
		jz equal

	notEqual:
		printf unequalstr
		jmp exit

	equal:
		printf equalstr

	exit:
		printf length1
		print l1
		printf length2
		print l2
		mov ah,4ch
		int 21h

end

