; Procedimientos de la calculadora de matrices
; Autor: Angel Emiliano Escobar Hernandez
; Proyecto academico de Estructura y Programacion de Computadoras
.model small
.data
ten equ 10
.code
public gotoxy
public strBuild
public SumaMatrices
public LeerNumeros
public PrintFilaMat
public ConvertirMatriz
public TransponMatriz
public MultMatriz
public SumaDiagonalMatriz
public SumaElementosProce
public ConvertirASCII
public SumaColumnasproc
public SumaRenglonesproc
public ConvertirMatrizWord
public ConvertirWordASCII
public PrintFilaMat3
; declaración del proceso
gotoxy proc
	mov bp,sp
	add bp,04; valor de renglón
	mov dh,[bp]
	sub bp,02; valor de columna
	mov dl,[bp]
	mov bh,00; página
	mov ah,02
	int 10h
	ret 4
gotoxy endp

strBuild proc
mov bp,sp
add bp,02; vectorTiempo
mov cx,04
mov di,[bp]
cast:
	xor ax,ax
	mov al,[di]
	mov bl,ten
	div bl;
	xor ax,03030h; obteniendo código ascii más significativo
	mov [si],al
	inc si
	mov [si],ah
	inc si
	inc si
	inc di
	loop cast
	ret 2
strBuild endp

SumaMatrices proc
mov bp,sp
add bp,6; Direccion de M1
mov bx,[bp]
sub bp,2
mov di,[bp];Direccion de M2
sub bp,2
mov si,[bp];Direccion de matriz RESULTANTE
mov cx,10h; DEFINIENDO CONTADOR EN 16 HEXADECIMAL
SUMA_MATRICES:;ETIQUETA DEL LOOP
mov al,[bx]; COPIA EL PRIMER ELEMENTO DE M1 A LA PARTE BAJA DE AX
add al,[di]; SUMA EL PRIMER ELEMENTO DE M2 CON EL PRIMER ELEMENTO DE M1
mov [si],al; COPIA EL RESULTADO AL PRIMER ELEMENTO DE matriz RESULTANTE
inc bx; APUNTA AL SIGUIENTE ELEMENTO DE M1
inc di; APUNTA AL SIGUIENTE ELEMENTO DE M2
inc si; APUNTA AL SIGUIENTE ELEMENTO DE la matriz RESULTANTE
loop SUMA_MATRICES; REGRESA A LA ETIQUETA PARA HACER LA ITERACION DEL CODIGO DENTRO DE LA MISMA
ret 6
SumaMatrices endp

LeerNumeros PROC
    mov bp, sp
    add bp, 04            ; DirCADENA
    mov si,[bp]
    add si, 02            ; DirPrimerCaracter
    sub bp,02
    mov di,[bp]           ; DIRMATRIZ
    xor dx, dx
	xor ax, ax
    mov CX, 16
LeerChar:
    xor bx, bx
    mov bl, [si]
    inc si
    cmp bl, 13
    je GuardarFinal
    cmp bl, ','
    je GuardarNumero
    ; ---- ASCII → número HEXADECIMAL
    sub bl, 30h
	mov ah,0
    mov ax,dx
    mov dl,ten
    mul dl
    add bx, ax
    mov dx, bx
    jmp LeerChar
GuardarNumero:
    mov [di], dl          ; cada elemento ocupa exactamente un byte
    inc di
    xor dx, dx
    loop LeerChar
    jmp Salir
GuardarFinal:
    mov [di],dl ; GUARDA el ultimo ELEMENTO
Salir:
    ret 4
LeerNumeros endp

ConvertirMatriz proc
    mov bp,sp
    add bp,04
    mov si,[bp]       ; vector destino
    sub bp,02
    mov di,[bp]       ; matriz
    mov cx,16
Conv:
    xor ax,ax
    mov al,[di]       ; AL = HEX (ej: 41h)
    mov bl,ten         ; divisor decimal
    div bl            ; AL = decenas, AH = unidades
    xor ax,3030h      ; convertir a ASCII
    mov [si],al       ; decenas ASCII
    inc si
    mov [si],ah       ; unidades ASCII
    inc si
    inc di            ; siguiente byte matriz
loop Conv
ret 4
ConvertirMatriz endp

; Convierte 16 palabras sin signo (0..999) a tres caracteres ASCII.
ConvertirMatrizWord proc
    mov bp,sp
    add bp,04
    mov si,[bp]           ; vector destino
    sub bp,02
    mov di,[bp]           ; matriz de palabras
    mov cx,16
ConvWord:
    mov ax,[di]
    xor dx,dx
    mov bx,100
    div bx
    add al,'0'
    mov [si],al
    inc si

    mov ax,dx
    xor dx,dx
    mov bx,10
    div bx
    add al,'0'
    mov [si],al
    inc si
    add dl,'0'
    mov [si],dl
    inc si

    add di,2
    loop ConvWord
    ret 4
ConvertirMatrizWord endp

; Convierte n palabras sin signo (0..999) a tres caracteres ASCII.
ConvertirWordASCII proc
    mov bp,sp
    add bp,06
    mov si,[bp]           ; vector destino
    sub bp,02
    mov di,[bp]           ; vector de palabras
    sub bp,02
    mov cx,[bp]           ; cantidad de palabras
ConvWordN:
    mov ax,[di]
    xor dx,dx
    mov bx,100
    div bx
    add al,'0'
    mov [si],al
    inc si

    mov ax,dx
    xor dx,dx
    mov bx,10
    div bx
    add al,'0'
    mov [si],al
    inc si
    add dl,'0'
    mov [si],dl
    inc si

    add di,2
    loop ConvWordN
    ret 6
ConvertirWordASCII endp

PrintFilaMat proc
	xor si,si
	xor bx,bx
	xor ax,ax
	xor dx,dx
    mov bp,sp
    add bp,06
    mov bl,[bp]          ; y (columna)
    sub bp,02
    mov dh,[bp]          ; x (fila)
    sub bp,02
    mov si,[bp]          ; matriz
    mov bh,0
    mov cx,4             ; 4 numeros
PrintFila:
    mov dl,bl
	mov bh,0
    mov ah,02h
    int 10h  ; posiciona cursor
    mov dl,[si]
    mov ah,02
    int 21h
	inc bl; imprime primer digito
    mov dl,bl
    inc si
    mov ah,02h
    int 10h
    mov dl,[si]
    mov ah,02
    int 21h 	; imprime segundo digito
	inc bl
	mov dl,bl
    mov ah,02h
    int 10h
    mov dl,' ' ; imprime espacio
    mov ah,02
    int 21h
	inc bl
	inc si
loop PrintFila
    ret 6
PrintFilaMat endp

; Imprime cuatro numeros de tres digitos separados por espacios.
PrintFilaMat3 proc
    mov bp,sp
    add bp,06
    mov dl,[bp]           ; columna
    sub bp,02
    mov dh,[bp]           ; fila
    sub bp,02
    mov si,[bp]           ; cadena de la fila
    mov bh,0
    mov ah,02h
    int 10h
    mov cx,4
PrintFila3:
    push cx
    mov cx,3
PrintDigito3:
    mov dl,[si]
    mov ah,02h
    int 21h
    inc si
    loop PrintDigito3
    mov dl,' '
    mov ah,02h
    int 21h
    pop cx
    loop PrintFila3
    ret 6
PrintFilaMat3 endp

TransponMatriz proc
;Obtener la matriz transpuesta
mov bp,sp
add bp,4
mov si,[bp]; si apunta a la Direccion de la matriz original
sub bp,2
mov di,[bp]; SI APUNTA AL PRIMER ELEMENTO DE LA MATRIZ RESULTANTE
; DI APUNTA AL PRIMER ELEMENTO DE LA MATRIZ TRANSPUESTA
mov dx,04h; INICIALIZANDO EL CONTADOR DEL LOOP EXTERNO (columnas)
mov cx,dx; COPIANDO EL NÚMERO DE ITERACIÓN ACTUAL, AL CONTADOR DEL LOOP EXTERNO
columnas:;LOOP EXTERIOR
mov bx,si; COPIA LA DIRECCION DE MATRIZ la matriz original A BX
mov cx,04h; DEFINIENDO CONTADOR DEL LOOP INTERIOR FILAS EN 4
filas:;LOOP INTERIOR
mov al,[bx]; COPIAN EL PRIMER ELEMENTO DE la matriz original A LA PARTE BAJA DE AX
mov [di],al; COPIA EL CONTENIDO DE AL EN EL PRIMER ELEMENTO DE LA TRANSPUESTA
add bx,04h; BX APUNTA AL PRIMER ELEMENTO DE LA SIGUIENTE FILA DE la matriz original
inc di; APUNTA AL SIGUIENTE ELEMENTO DE LA TRANSPUESTA
loop filas;REALIZA EL LOOP INTERIOR 4 VECES Y SALE AL LOOP EXTERIOR
inc si;SI APUNTA AL SIGUIENTE ELEMENTO DE la matriz original
mov cx,dx;COPIA EL CONTENIDO DEL CONTADOR EXTERNO
dec dx; DECREMENTA EL CONTADOR EXTERNO DE COLUMNAS
loop columnas; REGRESA AL LOOP EXTERIOR PARA ASI VOLVER A REALIZAR EL LOOP INTERIOR
ret 4
TransponMatriz endp

MultMatriz proc
    mov bp,sp
    add bp,06
    mov si,[bp]           ; matriz 1
    sub bp,02
    mov di,[bp]           ; matriz 2 transpuesta
    sub bp,02
    mov bx,[bp]           ; matriz resultado (palabras)
    mov dh,4              ; cuatro filas
MultFila:
    mov di,[bp+2]         ; primera fila de la matriz transpuesta
    mov dl,4              ; cuatro columnas
MultColumna:
    push si
    push di
    mov word ptr [bx],0
    mov cx,4
MultElemento:
    xor ax,ax
    mov al,[si]
    mul byte ptr [di]
    add word ptr [bx],ax
    inc si
    inc di
    loop MultElemento
    pop di
    pop si
    add di,4
    add bx,2
    dec dl
    jnz MultColumna
    add si,4
    dec dh
    jnz MultFila
    ret 6
MultMatriz endp

SumaDiagonalMatriz proc
mov bp,sp
add bp,4
mov si,[bp];SI APUNTA AL PRIMER ELEMENTO DE LA MATRIZ
sub bp,2
mov di,[bp]; DI APUNTA A LA VARIABLE DONDE SE VA A GUARDAR EL RESULTADO
xor al,al
mov [di],al
xor ax,ax;LIMPIA EL REGISTRO AX AX=0
mov cx,04h; DEFINIMOS CONTADOR DEL LOOP EN 4, PARA SUMAR LOS 4 ELEMENTOS DE LA DIAGONAL
SumaDiagonal:;ETIQUETA DEL LOOP
mov al,[si];COPIAMOS EL PRIMER ELEMENTO DE LA DIAGONAL PRINCIPAL
add [di],al;UTILIZAMOS COMO ACUMULADOR EL MISMO ELEMENTO DONDE SE VA A GUARDAR EL RESULTADO Y SUMAMOS EL CONTENIDO COPIADO EN AL
add si,05h; SI APUNTA AL SIGUIENTE ELEMENTO DE LA DIAGONAL PRINCIPAL
loop SumaDiagonal; REALIZA EL LOOP SUMA DIAGONAL
ret 4
SumaDiagonalMatriz endp

SumaElementosProce proc
mov bp,sp
add bp,4
mov di,[bp];DI APUNTA AL PRIMER ELEMENTO DE LA MATRIZ
sub bp,2
mov si,[bp];SI APUNTA A LA VARIABLE DONDE SE VA A GUARDAR EL RESULTADO DE LA SUMA TOTAL
;SUMAR TODOS LOS ELEMENTOS DE LA MATRIZ
xor ax,ax
mov [si],ax
xor ax,ax; LIMPIAMOS EL REGISTRO AX=0
mov cx,10h; DEFINIMOS EL CONTADOR DE LAS ITERACIONES EN 16 DECIMAL
SumaElementos:; ETIQUETA DEL LOOP
mov al,[di]; COPIA EL ELEMENTO CORRESPONDIENTE DE LA MATRIZ
add [si],ax; UTILIZAMOS COMO ACUMULADOR LA VARIABLE DONDE SE VA A GUARDAR LA SUMA Y SUMAMOS EL ELEMENTO ANTERIORMENTE COPIADO EN AX
inc di; DI APUNTA AL SIGUIENTE ELEMENTO DE LA MATRIZ
loop SumaElementos; REALIZA EL LOOP SUMA ELEMENTOS 16 VECES Y TERMINA
ret 4
SumaElementosProce endp

ConvertirASCII proc
    mov bp,sp
    add bp,06
    mov si,[bp]       ; vector destino
    sub bp,02
    mov di,[bp]       ; matriz
	sub bp,2
	mov cx,[bp]		;bytes a leer
Conver:
    xor ax,ax
    mov al,[di]       ; AL = HEX (ej: 41h)
    mov bl,ten         ; divisor decimal
    div bl            ; AL = decenas, AH = unidades
    xor ax,3030h      ; convertir a ASCII
    mov [si],al       ; decenas ASCII
    inc si
    mov [si],ah       ; unidades ASCII
    inc si
    inc di            ; siguiente byte matriz
loop Conver
ret 6
ConvertirASCII endp

SumaColumnasproc proc
mov bp,sp
add bp,4
mov si,[bp]; SI APUNTA AL PRIMER ELEMENTO DE la matriz
sub bp,2
mov di,[bp];DI APUNTA AL VECTOR DONDE SE GUARDARÁ LA SUMA DE LAS COLUMNAS
mov dx,04h;INICIALIZANDO EL CONTADOR DEL LOOP EXTERNO (RECORRER COLUMNA)
mov cx,dx; COPIANDO EL NÚMERO DE ITERACIÓN ACTUAL, AL CONTADOR DEL LOOP EXTERNO
RecorrerColumna:;LOOP EXTERIOR
mov bx,si; BX APUNTA AL PRIMER ELEMENTO DE LA COLUMNA CORRESPONDIENTE
xor ax,ax;LIMPIA EL REGISTRO AX AX=0
mov [di],al
mov cx,04h; DEFINIENDO CONTADOR DE LOOP INTERIOR SUMA COLUMNA EN 4 PARA RECORRER LOS ELEMENTOS DE LA COLUMNA
SumaColumna:;LOOP INTERIOR
mov al,[bx];COPIA EL PRIMER ELEMENTO DE LA COLUMNA
add [di],al;UTILIZANDO EL PRIMER ELEMENTO DEL VECTOR DONDE SE VA A GUARDAR LA SUMA COMO ACUMULADOR SUMAMOS EL ELEMENTO COPIADO EN AL
add bx,04h; APUNTAMOS AL SIGUIENTE ELEMENTO EN LA COLUMNA
loop SumaColumna;REALIZA EL LOOP INTERIOR 4 VECES Y SALE AL LOOP EXTERIOR
inc si; SI APUNTA AL PRIMER ELEMENTO DE LA SIGUIENTE COLUMNA
inc di; DI APUNTA AL SIGUIENTE ELEMENTO DE DONDE SE VA A REALIZAR LA SUMA
mov cx,dx; COPIA EL CONTENIDO DEL CONTADOR EXTERNO
dec dx; DECREMENTA EL CONTADOR EXTERNO DE RECORRER COLUMNA
loop RecorrerColumna; REGRESA AL LOOP EXTERIOR PARA ASI VOLVER A REALIZAR EL LOOP INTERIOR

ret 4
SumaColumnasproc endp

SumaRenglonesproc proc
mov bp,sp
add bp,4
mov si,[bp]; SI APUNTA AL PRIMER ELEMENTO DE la matriz 1
sub bp,2
mov di,[bp]; DI APUNTA AL VECTOR DONDE SE GUARDARÁ LA SUMA DE LOS RENGLONES
mov dx,04h;INICIALIZANDO EL CONTADOR DEL LOOP EXTERNO (RECORRER FILA)
mov cx,dx; COPIANDO EL NÚMERO DE ITERACIÓN ACTUAL, AL CONTADOR DEL LOOP EXTERNO
RecorrerFila:;LOOP EXTERIOR
mov bx,si; BX APUNTA AL PRIMER ELEMENTO DE LA FILA CORRESPONDIENTE
xor ax,ax;LIMPIA EL REGISTRO AX AX=0
mov [di],al
mov cx,04h; DEFINIENDO CONTADOR DE LOOP INTERIOR SUMA FILA EN 4 PARA RECORRER LOS ELEMENTOS DE LA FILA
SumaFila:;LOOP INTERIOR
mov al,[bx];COPIA EL PRIMER ELEMENTO DE LA FILA
add [di],al;;UTILIZANDO EL PRIMER ELEMENTO DEL VECTOR DONDE SE VA A GUARDAR LA SUMA COMO ACUMULADOR SUMAMOS EL ELEMENTO COPIADO EN AL
inc bx; BX APUNTA AL SIGUIENTE ELEMENTO DE LA FILA
loop SumaFila;REALIZA EL LOOP INTERIOR 4 VECES Y SALE AL LOOP EXTERIOR
add si,04h; SI APUNTA AL PRIMER ELEMENTO DE LA SIGUIENTE FILA
inc di;DI APUNTA AL SIGUIENTE ELEMENTO DEL VECTOR DONDE SE VA A REALIZAR LA SUMA
mov cx,dx; COPIA EL CONTENIDO DEL CONTADOR EXTERNO
dec dx; DECREMENTA EL CONTADOR EXTERNO DE RECORRER COLUMNA
loop RecorrerFila; REGRESA AL LOOP EXTERIOR PARA ASI VOLVER A REALIZAR EL LOOP INTERIOR
ret 4
SumaRenglonesproc endp
end
