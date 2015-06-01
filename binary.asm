.model small
.data
data dw 2h,5h,6h,7h,9h
len dw $-data
found db "Element Found at $"
notFound db "Element not Found$"
key dw 2h
pos db ?
.code
  mov ax,@data
  mov ds,ax
  mov si,0   ;storing low in SI
  mov di,len
  shr di,01		;single 16bit number will amount for 2 bytes in len
  dec di  ;storing high in DI

  while1: cmp si,di
  		  ja notFnd    ;come out of the loop if SI is larger than DI
  		  mov bx,si
  		  add bx,di
  		  shr bx,01
  		  mov cx,bx
  		  shl bx,1
  		  mov ax,data[bx]
  		  cmp ax,key
  		  je fnd
  		  cmp key,ax
  		  ja inclow
  		  mov di,cx
  		  dec di
  		  jmp while1

  inclow: mov si,cx
  		  inc si
  		  jmp while1

  fnd: lea dx,found
  		 mov ah,09h
  		 int 21h
  		 ;inc bx
  		 mov dx,cx
  		 add dx,30h
  		 mov ah,02h
  		 int 21h
  		 jmp exit

  notFnd: lea dx,notFound
  		 mov ah,09h
  		 int 21h  		
  		 jmp exit

exit:  mov ah,4ch
       int 21h

end