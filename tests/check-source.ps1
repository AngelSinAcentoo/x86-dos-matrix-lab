$ErrorActionPreference = 'Stop'

$repo = Split-Path -Parent $PSScriptRoot
$required = @(
    'README.md',
    'LICENSE',
    'BUILD.BAT',
    'RUN.BAT',
    'src\PROYECTO.ASM',
    'src\PROCED.ASM',
    'src\MACROS.INC'
)

foreach ($relative in $required) {
    $path = Join-Path $repo $relative
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Falta el archivo requerido: $relative"
    }
}

$project = Get-Content -LiteralPath (Join-Path $repo 'src\PROYECTO.ASM') -Raw
$procedures = Get-Content -LiteralPath (Join-Path $repo 'src\PROCED.ASM') -Raw

$checks = @{
    'Una sola llamada a multiplicacion' =
        ([regex]::Matches($project, '(?im)^\s*MultMatrizM\s+').Count -eq 1)
    'Lector almacena bytes' =
        ($procedures -match '(?im)^\s*mov\s+\[di\],\s*dl\b')
    'Multiplicacion avanza palabras' =
        ($procedures -match '(?im)^\s*add\s+bx,\s*2\b')
    'Resultados de producto usan tres digitos' =
        ($project -match '(?im)^\s*ConvertirMatrizWordM\b')
    'No se referencia la macro antigua' =
        ($project -notmatch '(?i)macrosP\.inc')
}

$failed = $checks.GetEnumerator() | Where-Object { -not $_.Value }
if ($failed) {
    $failed.Name | ForEach-Object { Write-Error "Fallo: $_" }
    exit 1
}

$ignore = Get-Content -LiteralPath (Join-Path $repo '.gitignore') -Raw
foreach ($pattern in '*.EXE', '*.OBJ', '*.LST', '*.MAP', '*.LIB') {
    if ($ignore -notmatch [regex]::Escape($pattern)) {
        throw "Falta ignorar el patron generado: $pattern"
    }
}

Write-Host "Comprobaciones estaticas superadas: $($checks.Count)"
