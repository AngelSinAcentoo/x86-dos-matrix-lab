# Arquitectura

La aplicación se divide en tres módulos:

1. `PROYECTO.ASM` contiene datos, menú, captura de matrices y presentación.
2. `MACROS.INC` conserva registros con `pusha/popa`, coloca argumentos en la
   pila y llama a procedimientos.
3. `PROCED.ASM` implementa algoritmos, conversión decimal y salida tabular.

## Flujo de datos

Las cadenas capturadas por DOS `21h/0Ah` se convierten a matrices de 16 bytes.
Las operaciones de suma, transposición y agregación producen bytes. La
multiplicación produce 16 palabras para evitar desbordamiento y se convierte
a grupos de tres caracteres antes de imprimirse.

Los procedimientos retiran sus argumentos con `ret n`; las macros restauran
los registros del llamador después de cada operación.
