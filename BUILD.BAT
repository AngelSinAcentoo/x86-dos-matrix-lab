@echo off
echo Compilando calculadora de matrices...
set TOOL=
if exist T:\TASM.EXE set TOOL=T:\
cd src

%TOOL%tasm /m2 PROYECTO.ASM
if errorlevel 1 goto error

%TOOL%tasm /m2 PROCED.ASM
if errorlevel 1 goto error

%TOOL%tlink PROYECTO+PROCED
if errorlevel 1 goto error

echo.
echo Compilacion terminada: SRC\PROYECTO.EXE
cd ..
goto fin

:error
echo.
echo La compilacion fallo. Revisa los mensajes de TASM/TLINK.
cd ..
exit /b 1

:fin
