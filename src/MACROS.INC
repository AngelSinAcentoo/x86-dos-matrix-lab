; Macros de la calculadora de matrices
; Autor: Angel Emiliano Escobar Hernandez
; Proyecto academico de Estructura y Programacion de Computadoras
; resuelve el segmento de datos
initr macro
	mov ax, @data
	mov ds, ax  ; resuelve el segmento de datos
	mov es, ax  ; el segmento extra lo apuntamos al segmentos de datos
endm

; limpia pantalla
clrscr macro
	MOV AH,0FH;		limpia pantalla
	INT 10H
	MOV AH,0
	INT 10H
endm

; omite cursor
cursorOff macro
	mov ah,01h
	mov cx,02607h
	int 10h
endm

; ubica cursor
gotoxyM macro ren, col
	pusha
	mov renglon,ren
	mov columna,col
	push renglon
	push columna
	call gotoxy
	popa
endm

; obteniendo el tiempo
snapTime macro
	mov ah,02Ch
	int 21h
endm

; construyendo cadena de tiempo
constrCadT macro dirVect
	pusha
	push dirVect
	call strBuild
	popa
endm

; imprimir cadena
impCad macro nomCad
	mov ah,09
	mov dx, offset nomCad
	int 21h
endm

;imprimir coma
impComa macro
mov ah,02
mov dl,44
int 21h
endm

;escanear tecla
scanop macro
	mov ah,08
	int 21h
	and al,0DFh
endm

;recibir cadena de teclado
scanstring macro DirCadena
	mov ah,0Ah
	mov dx,offset DirCadena
	int 21h
endm

;macro para sumar matrices
SumaMatricesM macro DirMatriz1,DirMatriz2,DirMatrizR
pusha
push DirMatriz1
push DirMatriz2
push DirMatrizR
call SumaMatrices
popa
endm

;macro para leer cadenas
LeerNumerosM macro DirCaracteres,DirMatriz
pusha
push DirCaracteres
push DirMatriz
call LeerNumeros
popa
endm

;macro para pasar cadenas
PasarNumerosM macro DirCaracteres,DirMatriz
pusha
push DirCaracteres
push DirMatriz
call PasarNumeros
popa
endm

;convertir
ConvertirMatrizM macro DirMatriz,DirVector
pusha
push DirVector
push DirMatriz
call ConvertirMatriz
popa
endm

;macro para imprimir matrices
PrintFilaMatM macro DirMat,x,y
pusha
mov renglon,x
mov columna,y
push renglon
push columna
push DirMat
call PrintFilaMat
popa
endm

;macro para transponer la matriz
TransponMatrizM macro DirMatriz,DirMatrizResT
pusha
push DirMatriz
push DirMatrizResT
call TransponMatriz
popa
endm

;macro para multiplicar matrices
MultMatrizM macro DirMatriz,DirMatriz2,DirMatrizRes
	pusha
	push DirMatriz
	push DirMatriz2
	push DirMatrizRes
	call MultMatriz
	popa
endm

; convierte 16 palabras (0..324) a cadenas de tres digitos
ConvertirMatrizWordM macro DirMatriz,DirVector
	pusha
	push DirVector
	push DirMatriz
	call ConvertirMatrizWord
	popa
endm

; convierte una cantidad indicada de palabras a tres digitos
ConvertirWordASCIIM macro DirResultado,DirCadena,n
	pusha
	mov digitos,n
	push DirCadena
	push DirResultado
	push digitos
	call ConvertirWordASCII
	popa
endm

; imprime una fila de cuatro numeros de tres digitos
PrintFilaMat3M macro DirMat,x,y
	pusha
	mov renglon,x
	mov columna,y
	push renglon
	push columna
	push DirMat
	call PrintFilaMat3
	popa
endm

;macro para sumar los elementos de una matriz
SumaElementosM macro DirMatriz,DirSumaTotal
pusha
push DirMatriz
push DirSumaTotal
call SumaElementosProce
popa
endm

;macro para sumar los elementos de la diagonal
SumaDiagonalM macro DirM,DirSumaDiago
pusha
push DirM
push DirSumaDiago
call SumaDiagonalMatriz
popa
endm

;macro convertir a decimal y posteriormente a ASCII
ConvertirASCIIM macro DirResultado,DirCadena,n
pusha
mov digitos,n
push DirCadena
push DirResultado
push digitos
call ConvertirASCII
popa
endm

;macro para sumar columnas de la matriz
SumaColumnasprocM macro DirM,DirSumaCol
pusha
push DirM
push DirSumaCol
call SumaColumnasproc
popa
endm

;macro para sumar renglones de la matriz
SumaRenglonesprocM macro DirM,DirSumaCol
pusha
push DirM
push DirSumaCol
call SumaRenglonesproc
popa
endm
