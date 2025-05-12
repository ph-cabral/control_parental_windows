@echo off
setlocal enabledelayedexpansion

::============================================
:: Obtener usuarios
::============================================
rem Leer la lista de administradores desde el archivo
set "ADMIS="
for /f "delims=" %%A in (_usuarios.txt) do (
    set "ADMIS=!ADMIS! %%A"
)


rem Obtener carpetas de usuario
set "USUARIOS="
for /f "delims=" %%a in ('dir "C:\Users" /b /ad-h') do (
    set "EXCLUIR=0"
    
    for %%b in (!ADMIS!) do (
        if /i "%%a"=="%%b" set "EXCLUIR=1"
    )

    if !EXCLUIR! EQU 0 (
        set "USUARIOS=!USUARIOS! %%a"
    )
)


::============================================
:: Obtener el nombre del usuario actual
::============================================
set "USUARIO=%USERNAME%"
set "ARCHIVO_TIEMPO=%USERPROFILE%\tiempo_%USUARIO%.txt"


echo %USUARIO%  
::============================================
:: buscamos si esta en la lista
::============================================
set "ENCONTRADO=0"
for %%U in (%USUARIOS%) do (
    if /I "%%U" == "%USUARIO%" (
        set "ENCONTRADO=1"
        echo esta en la lista
    )
)


::============================================
:: Si no está en la lista, salir del script
::============================================
if "!ENCONTRADO!"=="0" (
    echo no estaba en la lista
    exit
)


::============================================
:: Si el archivo no existe, salir del script
::============================================
if not exist "%ARCHIVO_TIEMPO%" (
    echo no esta el archivo
    shutdown /l /f
)





echo inicia el bucle
:countdown
::============================================
:: Inicia la cuenta regresiva
::============================================
timeout /t 1 /nobreak >nul

:: Leer el tiempo restante del archivo
set "restante="
for /f "delims=" %%A in ('type "!ARCHIVO_TIEMPO!"') do set "restante=%%A"
echo %restante%
:: Restar 1 minuto
set /a restante-=1

:: Guardar el tiempo actualizado
echo !restante! > "%ARCHIVO_TIEMPO%"

:: Si se agotó el tiempo, cerrar sesión
if !restante! leq 0 (
    attrib -h "%ARCHIVO_TIEMPO%" >nul 2>&1
    del "%ARCHIVO_TIEMPO%"
    shutdown /l /f
    echo sin tiempo
)

goto countdown