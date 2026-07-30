title Pruebas automaticas de algoritmos
.model small
.286
.stack 128

.data
M1 db 1,2,3,4, 5,6,7,8, 9,0,1,2, 3,4,5,6
M2 db 9,8,7,6, 5,4,3,2, 1,0,9,8, 7,6,5,4
Identidad db 1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1

SumaEsperada db 10,10,10,10, 10,10,10,10
              db 10,0,10,10, 10,10,10,10
TranspuestaEsperada db 1,5,9,3, 2,6,0,4
                     db 3,7,1,5, 4,8,2,6
ColumnasEsperadas db 18,12,16,20
RenglonesEsperados db 10,26,12,18
ProductoEsperado dw 1,2,3,4, 5,6,7,8
                 dw 9,0,1,2, 3,4,5,6

ResultadoBytes db 16 dup(0)
ResultadoWords dw 16 dup(0)
Resultado4 db 4 dup(0)
ResultadoByte db 0
ResultadoWord dw 0

Entrada db 48,31
        db '1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6',13
EntradaResultado db 16 dup(0)

ValoresWord dw 0,66,324
CadenaWord db 9 dup(0)
CadenaEsperada db '000066324'
MensajePass db 'PASS',13,10,'$'
MensajeFail db 'FAIL 0',13,10,'$'

.code
extrn SumaMatrices:proc
extrn LeerNumeros:proc
extrn TransponMatriz:proc
extrn MultMatriz:proc
extrn SumaDiagonalMatriz:proc
extrn SumaElementosProce:proc
extrn SumaColumnasproc:proc
extrn SumaRenglonesproc:proc
extrn ConvertirWordASCII:proc

start:
    mov ax,@data
    mov ds,ax
    mov es,ax
    cld

    ; Lectura de 16 elementos.
    push offset Entrada
    push offset EntradaResultado
    call LeerNumeros
    mov dl,1
    mov si,offset EntradaResultado
    mov di,offset M1
    mov cx,16
    repe cmpsb
    je lectura_ok
    jmp fallo
lectura_ok:

    ; Suma elemento a elemento.
    push offset M1
    push offset M2
    push offset ResultadoBytes
    call SumaMatrices
    mov dl,2
    mov si,offset ResultadoBytes
    mov di,offset SumaEsperada
    mov cx,16
    repe cmpsb
    je suma_ok
    jmp fallo
suma_ok:

    ; Transpuesta.
    push offset M1
    push offset ResultadoBytes
    call TransponMatriz
    mov dl,3
    mov si,offset ResultadoBytes
    mov di,offset TranspuestaEsperada
    mov cx,16
    repe cmpsb
    je transpuesta_ok
    jmp fallo
transpuesta_ok:

    ; Identidad por M1. MultMatriz recibe la segunda matriz transpuesta.
    push offset Identidad
    push offset TranspuestaEsperada
    push offset ResultadoWords
    call MultMatriz
    mov dl,4
    mov si,offset ResultadoWords
    mov di,offset ProductoEsperado
    mov cx,16
    repe cmpsw
    je producto_ok
    jmp fallo
producto_ok:

    ; Suma de la diagonal.
    mov ResultadoByte,99
    push offset M1
    push offset ResultadoByte
    call SumaDiagonalMatriz
    mov dl,5
    cmp ResultadoByte,14
    je diagonal_ok
    jmp fallo
diagonal_ok:

    ; Suma de todos los elementos.
    mov ResultadoWord,999
    push offset M1
    push offset ResultadoWord
    call SumaElementosProce
    mov dl,6
    cmp ResultadoWord,66
    je total_ok
    jmp fallo
total_ok:

    ; Sumas por columnas.
    push offset M1
    push offset Resultado4
    call SumaColumnasproc
    mov dl,7
    mov si,offset Resultado4
    mov di,offset ColumnasEsperadas
    mov cx,4
    repe cmpsb
    je columnas_ok
    jmp fallo
columnas_ok:

    ; Sumas por renglones y reinicio de acumuladores.
    mov Resultado4,99
    mov Resultado4+1,99
    mov Resultado4+2,99
    mov Resultado4+3,99
    push offset M1
    push offset Resultado4
    call SumaRenglonesproc
    mov dl,8
    mov si,offset Resultado4
    mov di,offset RenglonesEsperados
    mov cx,4
    repe cmpsb
    je renglones_ok
    jmp fallo
renglones_ok:

    ; Conversion de palabras a tres digitos.
    push offset CadenaWord
    push offset ValoresWord
    push 3
    call ConvertirWordASCII
    mov dl,9
    mov si,offset CadenaWord
    mov di,offset CadenaEsperada
    mov cx,9
    repe cmpsb
    je conversion_ok
    jmp fallo
conversion_ok:
    mov dx,offset MensajePass
    mov ah,09h
    int 21h
    mov ax,4C00h
    int 21h

fallo:
    add dl,'0'
    mov MensajeFail+5,dl
    mov dx,offset MensajeFail
    mov ah,09h
    int 21h
    mov ax,4C01h
    int 21h

end start
