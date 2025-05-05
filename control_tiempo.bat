@echo off
setlocal enabledelayedexpansion


:: ==============================================
:: Obtener usuarios
:: ==============================================
set "USUARIOS="
for /f "delims=" %%A in (_usuarios.txt) do (
    set "USUARIOS=!USUARIOS! %%A"
)


:: ==============================================
:: Obtener el nombre del usuario actual
:: ==============================================
set "USUARIO=%USERNAME%"
set "ARCHIVO_TIEMPO=%~dp0tiempo_%USUARIO%.txt"


:: ==============================================
:: Verificar si el usuario está en la lista
:: ==============================================
set "ENCONTRADO=0"
for %%U in (%USUARIOS%) do (
    if /I "%%U" == "%USUARIO%" (
 set "ENCONTRADO=1"
    )
)


:: ==============================================
:: Si no está en la lista, salir del script (no se controla)
:: ==============================================
if "!ENCONTRADO!"=="0" (
    exit
)


:: ==============================================
:: Si el archivo no existe, cerrar sesión
:: ==============================================
if not exist "%ARCHIVO_TIEMPO%" (
exit
)


:: ==============================================
:: Inicia la cuenta regresiva ""BUCLE""
:: ==============================================
:countdown
timeout /t 1 /nobreak >nul

:: Leer el tiempo restante del archivo
set "restante="
for /f "delims=" %%A in ('type "!ARCHIVO_TIEMPO!"') do set "restante=%%A"

:: Restar 1 minuto
set /a restante-=1

:: Guardar el tiempo actualizado
echo !restante! > "%ARCHIVO_TIEMPO%"

:: Si se agotó el tiempo, cerrar sesión
if !restante! leq 0 (
del "!ARCHIVO_TIEMPO!"
exit
)


goto countdown
