# Test vectors

All values are entered row by row.

## A. Addition

```text
M1 = 1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
M2 = 9,8,7,6,5,4,3,2,1,0,9,8,7,6,5,4
```

Expected result:

```text
10 10 10 10
10 10 10 10
10 00 10 10
10 10 10 10
```

## B. Transposition

Input:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

Expected result:

```text
01 05 09 03
02 06 00 04
03 07 01 05
04 08 02 06
```

## C. Multiplication

Use the identity matrix as `M1`:

```text
1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1
```

Use this matrix as `M2`:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

The result must match `M2`, printed with three digits per element.

## D through F. Sums

For this matrix:

```text
1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6
```

- Main diagonal: `14`
- Total: `066`
- Columns: `18,12,16,20`
- Rows: `10,26,12,18`

## Interaction flow

- `Esc` from the menu exits the program.
- `Esc` from an input or result screen returns to the menu.
- `Enter` after a result opens the repeat prompt.
- The repeat prompt accepts `S`/`s` for yes and `N`/`n` for no.
