title Programa para introducir cadena de caracteres Tarea
model small
stack 256
dataseg
exCode db 0
Cad1 db 'QuiERo ClASe'
cad2 db '            '
codeseg
start:
mov ax,@data
mov ds,ax
lea bx, Cad1
lea si,cad2
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
add bx,1
add si,1
mov ah,[bx]
xor ah,20h
mov [si],ah
exit:
mov ah,04ch
mov al,[exCode]
int 21h
end start
