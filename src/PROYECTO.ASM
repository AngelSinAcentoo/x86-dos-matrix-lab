; Calculadora de matrices 4x4 para DOS
; Autor: Angel Emiliano Escobar Hernandez
; Proyecto academico de Estructura y Programacion de Computadoras
Page 60, 132
title Proyecto
include MACROS.INC
.model small
.286
.stack 64
.data
ten equ 10
renglon dw 00; renglon para cursor
columna dw 00; columna para cursos
digitos dw 00; numero de digitos para pasar de hexadecimal a decimal y ascii
vectorTiempo db 00, 00, 00 ,00; vector del reloj
CadenaMatrizRes db 32 dup(0);donde se guardara el ascii de la matriz resultante a imprimir
CadenaMatrizResT db 32 dup(0);donde se guardara el ascii de la matriz transpuesta resultante a imprimir
CadenaMatrizImp1 db 32 dup(0);donde se guardara el ascii de la matriz 1 a imprimir
CadenaMatrizImp2 db 32 dup(0);donde se guardara el ascii de la matriz 2 a imprimir
CadenaMatrizImpT db 32 dup(0);donde se guardara el ascii de la matriz antes de transponer
CadenaMatrizResM db 48 dup(0); 16 resultados de tres digitos
CadenaMatrizRes1 db '00','$'; suma de la diagonal
CadenaMatrizRes2 db '000','$'; suma de todos los elementos
CadenaMatrizResSumas db 16 dup(0); donde se guardara el ascii del resultado de la suma de columnas o renglones
CadenaMatrizResSumas2 db 16 dup(0);donde se guardara el ascii del resultado de la suma de columnas o renglones
titulo db 'OPERACIONES CON MATRICES','$'
tiempo db 'HH:MM:SS:CS','$'
menuop1 db 'A) Suma de 2 Matrices','$'
menuop2 db 'B) Obtener transpuesta','$'
menuop3 db 'C) Multiplicar MATRICES','$'
menuop4 db 'D) Diagonal Principal y Suma','$'
menuop5 db 'E) Suma de columnas de una matriz','$'
menuop6 db 'F) Suma de Renglones de una matriz','$'
mensajeM1 db 'Inserte la matriz 1 por rengl',162,'n','$'
mensajeM2 db 'Inserte la matriz 2 por rengl',162,'n','$'
mensajeCOMA db '16 valores (0-9) separados por ","','$'
mensajeMatricesSuma db 'Estas son la matrices insertadas','$'
mensajeResultanteSuma db 'Esta es la suma de las matrices','$'
mensajeResultanteMult db 'Esta es la multiplicacion de las matrices','$'
mensajeResultanteSumaElementos db 'La suma de los elementos es:','$'
mensajeResultanteSumaDiagonal db 'La suma de la diagonal es:','$'
mensajeResultanteSumaCol db 'La suma de las columnas es:','$'
mensajeResultanteSumaRen db 'La suma de los renglones es:','$'
Matriz1 db 16 dup(0),'$';Matriz1 con numeros en hexadecimal
Matriz2 db 16 dup(0),'$';Matriz2 con numeros en hexadecimal
MatrizRes db 16 dup(0),'$';Matriz Resultante
MatrizT db 16 dup(0),'$'; Matriz antes de transponer
MatrizResT db 16 dup(0),'$';Matriz transpuesta
MatrizResM dw 16 dup(0),'$';Matriz de la multiplicacion
SumaCol db 0,0,0,0; INICIALIZANDO VECTOR DONDE GUARDAR EL RESULTADO DE LA SUMA DE COLUMNAS
SumaRen db 0,0,0,0; INICIALIZANDO VECTOR DONDE GUARDAR EL RESULTADO DE LA SUMA DE RENGLONES
SumaDiag db 0; INICIALIZANDO VARIABLE DONDE SE GUARDARA EL RESULTADO DE LA SUMA DE LA DIAGONAL
SumaMatriz dw 0; suma total maxima: 16*9 = 144
CadenaMatriz1 db 48,0,48 dup(0),'$';donde se guardará la cadena de la matriz 1 ingresada por el usuario
CadenaMatriz2 db 48,0,48 dup(0),'$';donde se guardará la cadena de la matriz 2 ingresada por el usuario
CadenaMatrizT db 48,0,48 dup(0),'$';donde se guardará la cadena de la matriz antes de transponer ingresada por el usuario
mensajeMatrizS db 'Esta es la matriz insertada','$'
mensajeMatrizT db 'Esta es la transpuesta de la matriz','$'
MopE db 'ESTA ES LA OPCION E','$'
MopF db 'ESTA ES LA OPCION F','$'
MopNULL db 168,'Deseas Realizar otra operaci',162,'n?','$'
MopNULL2 db 'Elige S',161,' [S] o No [N]','$'
.code
Menu proc far
extrn gotoxy:proc,strBuild:proc,SumaMatrices:proc,LeerNumeros:proc,PrintFilaMat:proc,ConvertirMatriz:proc,TransponMatriz:proc,MultMatriz:proc,SumaDiagonalMatriz:proc,SumaElementosProce:proc,ConvertirASCII:proc,SumaColumnasproc:proc,SumaRenglonesproc:proc,ConvertirMatrizWord:proc,ConvertirWordASCII:proc,PrintFilaMat3:proc
initr ; resuelve el segmento de datos
MenuOpciones:
clrscr ; Limpiar pantalla
cursorOff; remover el apuntador
gotoxyM 3,28 ;POS CURSOR PARA titulo
impCad titulo ;IMPRIMIR titulo
gotoxyM 9,30;POS CURSOR PARA opcion A
impCad menuop1;IMPRIMIR opciones A
gotoxyM 11,30;POS CURSOR PARA opcion B
impCad menuop2;IMPRIMIR opcion B
gotoxyM 13,30;POS CURSOR PARA opcion C
impCad menuop3;IMPRIMIR opcion C
gotoxyM 15,30;POS CURSOR PARA opcion D
impCad menuop4;IMPRIMIR opcion D
gotoxyM 17,30;POS CURSOR PARA opcion E
impCad menuop5;IMPRIMIR opcion E
gotoxyM 19,30;POS CURSOR PARA opcion F
impCad menuop6;IMPRIMIR opcion F
reloj:
	gotoxyM 5,34 ; ubicando cursor debajo del titulo del programa
	snapTime ; obteniendo el snapshot de tiempo
	mov si, offset tiempo
	; === ch -> hora cl -> min dh -> seg dl -> cs ===
	;cast de número a cadena
	;hora
	mov vectorTiempo,ch
	mov vectorTiempo+1,cl
	mov vectorTiempo+2,dh
	mov vectorTiempo+3,dl
	mov di, offset vectorTiempo
	constrCadT di
	; imprimiendo tiempo
	impCad tiempo
	in al,60h; obten lo pulsado en el puerto de HW 60h (60h es el teclado)
	cmp al,1
	je opFin
	cmp al,1eh
	je opA
	cmp al,30h
	je opB
	cmp al,2eh
	je opC
	cmp al,20h
	je opD
	cmp al,12h
	je opE
	cmp al,21h
	je opF
	jmp reloj
opFin:
jmp fin
opA:
jmp opcionA
opB:
jmp opcionB
opC:
jmp opcionC
opD:
jmp opcionD
opE:
jmp opcionE
opF:
jmp opcionF

opcionA:
clrscr ; Limpiar pantalla
gotoxyM 3,34 ;POS CURSOR
impCad mensajeM1;IMPRIMIR OPCION
gotoxyM 4,34; CURSOR
impCad mensajeCOMA; INSTRUCCION
gotoxyM 5,2
;lee cadena de la matriz 1
scanstring CadenaMatriz1
mov di, offset CadenaMatriz1
mov si, offset Matriz1
;pasa los numeros de la cadena a la matriz 1
LeerNumerosM di,si
gotoxyM 7,34 ;POS CURSOR
impCad mensajeM2;IMPRIMIR OPCION
gotoxyM 8,34
impCad mensajeCOMA;;imprime mensaje
gotoxyM 9,2
;lee cadena de la matriz 2
scanstring CadenaMatriz2
mov di, offset CadenaMatriz2
mov si, offset Matriz2
;pasa los numeros de la cadena a la matriz 2
LeerNumerosM di,si
mov bx,offset Matriz1
mov si,offset Matriz2
mov di,offset MatrizRes
;macro que llama al procedimiento de sumar matrices
SumaMatricesM bx,si,di
mov bx,offset MatrizRes
mov di,offset CadenaMatrizRes
;convierte la matriz resultante a decimal y posteriormente a ASCII
ConvertirMatrizM bx,di
mov bx,offset Matriz1
mov di,offset CadenaMatrizImp1
;convierte la matriz 1 a decimal y posteriormente a ASCII
ConvertirMatrizM bx,di
mov bx,offset Matriz2
mov di,offset CadenaMatrizImp2
;convierte la matriz 2 a decimal y posteriormente a ASCII
ConvertirMatrizM bx,di
xor ax,ax
;espera la tecla esc o 'I'
esperando:
in al,60h
cmp al,17h
je imprimeResultadoA
cmp al,1
je opcionesA1
jmp esperando

opcionesA1:
jmp MenuOpciones

imprimeResultadoA:
clrscr ; Limpiar pantalla
cursorOff;Remueve el cursor
gotoxyM 3,5 ;POS CURSOR
impCad mensajeMatricesSuma;IMPRIMIR OPCION
gotoxyM 3,40 ;POS CURSOR
impCad mensajeResultanteSuma;imprime mensaje
;imprimir matriz 1
mov di,offset CadenaMatrizImp1
PrintFilaMatM di,13,7
add di,8
PrintFilaMatM di,13,8
add di,8
PrintFilaMatM di,13,9
add di,8
PrintFilaMatM di,13,10
;imprimir matriz 2
mov di,offset CadenaMatrizImp2
PrintFilaMatM di,13,13
add di,8
PrintFilaMatM di,13,14
add di,8
PrintFilaMatM di,13,15
add di,8
PrintFilaMatM di,13,16
;impimir Matriz Resultante
mov di,offset CadenaMatrizRes
PrintFilaMatM di,50,10
add di,8
PrintFilaMatM di,50,11
add di,8
PrintFilaMatM di,50,12
add di,8
PrintFilaMatM di,50,13
xor ax,ax
;espera opcion esc o enter
esperando2:
in al,60h
cmp al,1
je opcionesA2
cmp al,1ch
je salida2
jmp esperando2

opcionesA2:
jmp MenuOpciones
salida2:
jmp OpcNULL


opcionB:
clrscr ; Limpiar pantalla
gotoxyM 3,34 ;POS CURSOR
impCad mensajeM1;IMPRIMIR OPCION
gotoxyM 4,34; CURSOR
impCad mensajeCOMA; INSTRUCCION
gotoxyM 5,2
;lee cadena de la matriz 1
scanstring CadenaMatrizT
mov di,offset CadenaMatrizT
mov si,offset MatrizT
;pasa los numeros de la cadena a la matriz
LeerNumerosM di,si
mov si,offset MatrizT
mov di,offset MatrizResT
;macro que llama al procedimiento de transponer la matriz
TransponMatrizM si,di
mov bx,offset MatrizT
mov di,offset CadenaMatrizImpT
;pasa la matriz de hexadecimal a decimal y post a ASCII
ConvertirMatrizM bx,di
mov bx,offset MatrizResT
mov di,offset CadenaMatrizResT
;pasa la matriz de hexadecimal a decimal y post a ASCII
ConvertirMatrizM bx,di
;ESPERA TECLA ESC O 'I'
esperando3:
in al,60h
cmp al,17h
je imprimeResultadoB
cmp al,1
je opcionesB1
jmp esperando3

opcionesB1:
jmp MenuOpciones

imprimeResultadoB:
clrscr ; Limpiar pantalla
cursorOff;Remueve el cursor
gotoxyM 3,5 ;POS CURSOR
impCad mensajeMatrizS;IMPRIMIR OPCION
gotoxyM 3,40 ;POS CURSOR
impCad mensajeMatrizT;
;imprimiendo la matriz ingresada
mov di,offset CadenaMatrizImpT
PrintFilaMatM di,15,10
add di,8
PrintFilaMatM di,15,11
add di,8
PrintFilaMatM di,15,12
add di,8
PrintFilaMatM di,15,13
;imprimiendo la matriz ya transpuesta
mov di,offset CadenaMatrizResT
PrintFilaMatM di,55,10
add di,8
PrintFilaMatM di,55,11
add di,8
PrintFilaMatM di,55,12
add di,8
PrintFilaMatM di,55,13
xor ax,ax
;espera la tecla esc o enter
esperando4:
in al,60h
cmp al,1
je opcionesB2
cmp al,1ch
je salida3
jmp esperando4

salida3:
jmp OpcNULL
opcionesB2:
jmp MenuOpciones

opcionC:
clrscr ; Limpiar pantalla
gotoxyM 3,34 ;POS CURSOR
impCad mensajeM1;IMPRIMIR OPCION
gotoxyM 4,34; CURSOR
impCad mensajeCOMA; INSTRUCCION
gotoxyM 5,2
;lee cadena de la matriz 1
scanstring CadenaMatriz1
;pasa los numeros de la cadena a la matriz 1
mov di, offset CadenaMatriz1
mov si, offset Matriz1
LeerNumerosM di,si
gotoxyM 7,34 ;POS CURSOR
impCad mensajeM2;IMPRIMIR OPCION
gotoxyM 8,34
impCad mensajeCOMA;
gotoxyM 9,2
;lee cadena de la matriz 2
scanstring CadenaMatriz2
mov di, offset CadenaMatriz2
mov si, offset Matriz2
;pasa los numeros de la cadena a la matriz 2
LeerNumerosM di,si
;macro que llama al procedimiento de transponer matriz y transpongo la matriz 2
mov si,offset Matriz2
mov di,offset MatrizResT
TransponMatrizM si,di
;macro que llama al procedimiento de la multiplicacion de matrices
mov bx,offset Matriz1
mov si,offset MatrizResT
mov di,offset MatrizResM
;multiplica las dos matrices completas
MultMatrizM bx,si,di
;convierte los resultados de palabra a tres digitos ASCII
mov bx,offset MatrizResM
mov di,offset CadenaMatrizResM
ConvertirMatrizWordM bx,di
;pasa la matriz de hexadecimal a decimal y a ascii
mov bx,offset Matriz1
mov di,offset CadenaMatrizImp1
;pasa la matriz de hexadecimal a decimal y a ascii
ConvertirMatrizM bx,di
mov bx,offset Matriz2
mov di,offset CadenaMatrizImp2
ConvertirMatrizM bx,di
;espera tecla 'I' o esc
esperando5:
in al,60h
cmp al,17h
je imprimeResultadoC
cmp al,1
je opcionesC1
jmp esperando5

opcionesC1:
jmp MenuOpciones

imprimeResultadoC:
clrscr ; Limpiar pantalla
cursorOff;Remueve el cursor
gotoxyM 3,5 ;POS CURSOR
impCad mensajeMatricesSuma;IMPRIMIR OPCION
gotoxyM 4,30 ;POS CURSOR
impCad mensajeResultanteMult
;imprimir matriz 1
mov di,offset CadenaMatrizImp1
PrintFilaMatM di,13,7
add di,8
PrintFilaMatM di,13,8
add di,8
PrintFilaMatM di,13,9
add di,8
PrintFilaMatM di,13,10
;imprimir matriz 2
mov di,offset CadenaMatrizImp2
PrintFilaMatM di,13,13
add di,8
PrintFilaMatM di,13,14
add di,8
PrintFilaMatM di,13,15
add di,8
PrintFilaMatM di,13,16
;impimir Matriz Resultante
mov di,offset CadenaMatrizResM
PrintFilaMat3M di,50,10
add di,12
PrintFilaMat3M di,50,11
add di,12
PrintFilaMat3M di,50,12
add di,12
PrintFilaMat3M di,50,13
xor ax,ax
;espera tecla esc o enter
esperando6:
in al,60h
cmp al,1
je opcionesC2
cmp al,1ch
je salida4
jmp esperando6

salida4:
jmp OpcNULL
opcionesC2:
jmp MenuOpciones



opcionD:
clrscr ; Limpiar pantalla
gotoxyM 3,34 ;POS CURSOR
impCad mensajeM1;IMPRIMIR OPCION
gotoxyM 4,34; CURSOR
impCad mensajeCOMA; INSTRUCCION
gotoxyM 5,2
;lee la cadena de la matriz
scanstring CadenaMatriz1
mov di,offset CadenaMatriz1
mov si,offset Matriz1
;pasa los numeros de la cadena a la matriz
LeerNumerosM di,si
mov bx,offset Matriz1
mov si,offset SumaMatriz
;macro que llama al procedimiento de sumar los elementos de la matriz
SumaElementosM bx,si
mov di,offset Matriz1
mov si,offset SumaDiag
;macro que llama al procedimiento de sumar la diagonal de la matriz
SumaDiagonalM di,si
;TransponMatrizM si,di
mov bx,offset Matriz1
mov di,offset CadenaMatrizImp1
;pasa la matriz de hexadecimal a decimal y post a ASCII
ConvertirMatrizM bx,di
mov bx,offset SumaDiag
mov si,offset CadenaMatrizRes1
;pasa el resultado de hexadecimal a decimal y a ascii
ConvertirASCIIM bx,si,1
mov bx,offset SumaMatriz
mov si,offset CadenaMatrizRes2
;convierte la suma total (palabra) a tres digitos
ConvertirWordASCIIM bx,si,1
;espera la tecla esc o 'I'
esperando7:
in al,60h
cmp al,17h
je imprimeResultadoD
cmp al,1
je opcionesD1
jmp esperando7

opcionesD1:
jmp MenuOpciones

imprimeResultadoD:
clrscr ; Limpiar pantalla
cursorOff;Remueve el cursor
gotoxyM 3,5 ;POS CURSOR
impCad mensajeMatrizS;IMPRIMIR OPCION
gotoxyM 12,21 ;POS CURSOR
impCad mensajeResultanteSumaDiagonal;
gotoxyM 13,21 ;POS CURSOR
impCad mensajeResultanteSumaElementos;
;imprimiendo la matriz ingresada
mov di,offset CadenaMatrizImp1
PrintFilaMatM di,7,10
add di,8
PrintFilaMatM di,7,11
add di,8
PrintFilaMatM di,7,12
add di,8
PrintFilaMatM di,7,13
;imprimiendo la suma de la Diagonal
mov di,offset CadenaMatrizRes1
gotoxyM 12,48
impCad CadenaMatrizRes1

;imprimiendo la suma de los elementos
mov di,offset CadenaMatrizRes2
gotoxyM 13,50
impCad CadenaMatrizRes2
;espera la tecla esc o enter
esperando8:
in al,60h
cmp al,1
je opcionesD2
cmp al,1ch
je salida5
jmp esperando8

salida5:
jmp OpcNULL
opcionesD2:
jmp MenuOpciones



opcionE:
clrscr ; Limpiar pantalla
gotoxyM 3,34 ;POS CURSOR
impCad mensajeM1;IMPRIMIR OPCION
gotoxyM 4,34; CURSOR
impCad mensajeCOMA; INSTRUCCION
gotoxyM 5,2
;lee la cadena de la matriz
scanstring CadenaMatriz1
mov di,offset CadenaMatriz1
mov si,offset Matriz1
;pasa los numeros de la cadena a la matriz
LeerNumerosM di,si
mov bx,offset Matriz1
mov si,offset SumaCol
;macro que llama al procedimiento de sumar columnas
SumaColumnasprocM bx,si
mov bx,offset Matriz1
mov di,offset CadenaMatrizImp1
;pasa el resultado de hexadecimal a decimal y a ascii
ConvertirMatrizM bx,di
mov bx,offset SumaCol
mov si,offset CadenaMatrizResSumas2
;pasa el resultado de la suma a ascii
ConvertirASCIIM bx,si,4
;espera la tecla esc o 'I'
esperando9:
in al,60h
cmp al,17h
je imprimeResultadoE
cmp al,1
je opcionesE1
jmp esperando9

opcionesE1:
jmp MenuOpciones

imprimeResultadoE:
clrscr ; Limpiar pantalla
cursorOff;Remueve el cursor
gotoxyM 3,5 ;POS CURSOR
impCad mensajeMatrizS;IMPRIMIR OPCION
gotoxyM 12,21 ;POS CURSOR
impCad mensajeResultanteSumaCol;
;imprimiendo la suma de laS Columnas
mov di,offset CadenaMatrizResSumas2
PrintFilaMatM di,49,12
gotoxyM 12,51 ;POS CURSOR
impComa
gotoxyM 12,54 ;POS CURSOR
impComa
gotoxyM 12,57 ;POS CURSOR
impComa
;imprimiendo la matriz ingresada
mov di,offset CadenaMatrizImp1
PrintFilaMatM di,7,10
add di,8
PrintFilaMatM di,7,11
add di,8
PrintFilaMatM di,7,12
add di,8
PrintFilaMatM di,7,13
;espera la tecla esc o enter
esperando10:
in al,60h
cmp al,1
je opcionesE2
cmp al,1ch
je salida6
jmp esperando10

salida6:
jmp OpcNULL
opcionesE2:
jmp MenuOpciones


opcionF:
clrscr ; Limpiar pantalla
gotoxyM 3,34 ;POS CURSOR
impCad mensajeM1;IMPRIMIR OPCION
gotoxyM 4,34; CURSOR
impCad mensajeCOMA; INSTRUCCION
gotoxyM 5,2
;lee la cadena de la matriz
scanstring CadenaMatriz1
mov di,offset CadenaMatriz1
mov si,offset Matriz1
;pasa los numeros de la cadena a la matriz
LeerNumerosM di,si
mov bx,offset Matriz1
mov si,offset SumaRen
;macro que llama al procedimiento de sumar Renglones de la matriz
SumaRenglonesprocM bx,si
mov bx,offset Matriz1
mov di,offset CadenaMatrizImp1
;pasa el resultado de la matriz hexadecimal a decimal y a ascii
ConvertirMatrizM bx,di
mov bx,offset SumaRen
mov si,offset CadenaMatrizResSumas2
;pasa el resultado de hexadecimal a decimal y a ascii
ConvertirASCIIM bx,si,4
;espera la tecla esc o 'I'
esperando11:
in al,60h
cmp al,17h
je imprimeResultadoF
cmp al,1
je opcionesF1
jmp esperando11

opcionesF1:
jmp MenuOpciones

imprimeResultadoF:
clrscr ; Limpiar pantalla
cursorOff;Remueve el cursor
gotoxyM 3,5 ;POS CURSOR
impCad mensajeMatrizS;IMPRIMIR OPCION
gotoxyM 12,21 ;POS CURSOR
impCad mensajeResultanteSumaRen;
;imprimiendo la suma de la Diagonal
mov di,offset CadenaMatrizResSumas2
PrintFilaMatM di,49,12
gotoxyM 12,51 ;POS CURSOR
impComa
gotoxyM 12,54 ;POS CURSOR
impComa
gotoxyM 12,57 ;POS CURSOR
impComa
;imprimiendo la matriz ingresada
mov di,offset CadenaMatrizImp1
PrintFilaMatM di,7,10
add di,8
PrintFilaMatM di,7,11
add di,8
PrintFilaMatM di,7,12
add di,8
PrintFilaMatM di,7,13
;espera la tecla esc o enter
esperando12:
in al,60h
cmp al,1
je opcionesF2
cmp al,1ch
je salida7
jmp esperando12

salida7:
jmp OpcNULL
opcionesF2:
jmp MenuOpciones


OpcNULL:
clrscr ; Limpiar pantalla
gotoxyM 3,28 ;POS CURSOR
impCad MopNULL ;IMPRIMIR OPCIOI
gotoxyM 5,28 ;POS CURSOR
impCad MopNULL2 ;IMPRIMIR OPCIOI
;espera la tecla S o N
esperando20:
scanop
cmp al,'S'
je ReturnMenu
cmp al,'N'
je fin
jmp esperando20
ReturnMenu:
jmp MenuOpciones


fin:
clrscr
mov ah,04ch
mov al,0
int 21h
Menu endp
end Menu
