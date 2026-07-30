@echo off
if not exist src\PROYECTO.EXE goto no_existe
cd src
PROYECTO.EXE
cd ..
goto fin

:no_existe
echo No existe SRC\PROYECTO.EXE. Ejecuta BUILD.BAT primero.
exit /b 1

:fin
