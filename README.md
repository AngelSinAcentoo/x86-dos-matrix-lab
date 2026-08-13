# x86 DOS Matrix Lab

An interactive 4x4 matrix calculator written in 16-bit x86 assembly for DOS. The project uses Turbo Assembler, BIOS and DOS interrupts, macros, public procedures, and the `small` memory model.

## Demo

![Matrix calculator main menu](docs/media/menu.png)

![Operations demo](docs/media/demo.gif)

## Features

- Addition of two matrices
- Matrix transposition
- Matrix multiplication
- Sum of the main diagonal and all elements
- Column sums
- Row sums
- A real-time clock using DOS interrupt `21h`

## Technologies and concepts

- Intel 80286 in 16-bit real mode
- Turbo Assembler 4.1 and Turbo Linker
- BIOS interrupt `10h` and DOS interrupt `21h`
- Modular organization with macros, procedures, and external symbols
- Manual stack, register, array, and decimal-to-ASCII handling

## Build and run

Requirements:

- DOSBox 0.74-3 or a compatible emulator
- Legally obtained copies of `TASM.EXE` and `TLINK.EXE`. These tools are not distributed in the repository

Mount the repository as drive `C:` and the TASM directory as drive `T:`:

```dos
mount c C:\path\to\x86-dos-matrix-lab
mount t C:\path\to\TASM
set PATH=%PATH%;T:\
c:
BUILD.BAT
RUN.BAT
```

`BUILD.BAT` assembles both modules and links them. Generated files remain under `src/` and are excluded from Git.

## Usage

The menu uses keys `A` through `F`. `Esc` returns to the previous screen or exits, depending on the current view.

Each matrix is entered as 16 values from 0 to 9 separated by commas:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

Values are read row by row. The 0 to 9 restriction keeps results within the interface formats:

- Values and partial sums use two digits.
- Products and the total sum use three digits.

## Repository structure

```text
.
├── src/
│   ├── PROYECTO.ASM   # menu, interface, and main flow
│   ├── PROCED.ASM     # algorithms and data conversion
│   └── MACROS.INC     # calling and input/output macros
├── exercises/         # complementary academic exercises
├── tests/             # reproducible test cases
├── BUILD.BAT
├── TEST.BAT
├── RUN.BAT
└── CLEAN.BAT
```

## Corrections in the portfolio version

The public version preserves the original design with these verifiable corrections:

- One byte is written per element during matrix input.
- Matrix multiplication covers the complete 4x4 result without overlapping words.
- Product conversion supports up to three digits.
- Accumulators are reset before repeated operations.
- Scalar results are printed independently.

## Tests

`TEST.BAT` builds the project and an assembly test harness. The harness calls the public procedures and exits with code `0` only when the input, addition, transposition, multiplication, partial-sum, accumulator-reset, and decimal-conversion cases pass.

```dos
TEST.BAT
```

The inputs and expected results are documented in [`tests/TEST-VECTORS.md`](tests/TEST-VECTORS.md).

## Scope

This academic project focuses on assembly language and x86 computer architecture. It is not a general-purpose matrix library and does not accept negative values, fractions, or variable matrix sizes.

## Author

**Angel Emiliano Escobar Hernández**

Computer Structure and Programming coursework.

Distributed under the [MIT License](LICENSE).
