# Architecture

The application is divided into three modules:

1. `PROYECTO.ASM` contains the data, menu, matrix input, and presentation logic.
2. `MACROS.INC` preserves registers with `pusha/popa`, places arguments on the stack, and calls procedures.
3. `PROCED.ASM` implements the algorithms, decimal conversion, and tabular output.

## Data flow

Strings captured through DOS service `21h/0Ah` are converted into 16-byte matrices. Addition, transposition, and aggregation operations produce byte values. Multiplication produces 16 words to avoid overflow and converts them into groups of three characters before printing.

Procedures remove their arguments with `ret n`. The macros restore the caller's registers after every operation.
