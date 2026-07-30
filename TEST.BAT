@echo off
call BUILD.BAT
if errorlevel 1 goto fallo

set TOOL=
if exist T:\TASM.EXE set TOOL=T:\
cd tests
%TOOL%tasm /m2 ALGTEST.ASM
if errorlevel 1 goto fallo_tests

%TOOL%tlink ALGTEST+..\src\PROCED
if errorlevel 1 goto fallo_tests

ALGTEST.EXE>\TEST.LOG
if errorlevel 1 goto fallo_tests

echo Pruebas de algoritmos superadas.
cd ..
goto fin

:fallo_tests
echo Fallaron las pruebas de algoritmos.
cd ..
exit /b 1

:fallo
echo No se pudieron ejecutar las pruebas.
echo FAIL>\TEST.LOG
exit /b 1

:fin
