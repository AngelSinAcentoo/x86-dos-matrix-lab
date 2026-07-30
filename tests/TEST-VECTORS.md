# Casos de prueba

Todos los datos se ingresan por renglones.

## A. Suma

```text
M1 = 1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
M2 = 9,8,7,6,5,4,3,2,1,0,9,8,7,6,5,4
```

Resultado:

```text
10 10 10 10
10 10 10 10
10 00 10 10
10 10 10 10
```

## B. Transpuesta

Entrada:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

Resultado:

```text
01 05 09 03
02 06 00 04
03 07 01 05
04 08 02 06
```

## C. Multiplicación

Usar la matriz identidad como `M1`:

```text
1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1
```

Y como `M2`:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

El resultado debe coincidir con `M2`, impreso con tres dígitos.

## D–F. Sumas

Para la matriz:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

- diagonal principal: `14`;
- suma total: `066`;
- columnas: `18,12,16,20`;
- renglones: `10,26,12,18`.

## Flujo

- `Esc` desde el menú termina el programa.
- `Esc` desde una captura o pantalla de resultados regresa al menú.
- `Enter` después de un resultado muestra la pregunta para repetir.
- La respuesta acepta `S`/`s` y `N`/`n`.
