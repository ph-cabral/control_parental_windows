@echo off
setlocal enabledelayedexpansion

:: Ruta del archivo en la misma carpeta que el script
set "archivo=%~dp0_usuarios.txt"

:: Si no existe, lo crea con el nombre del usuario actual
if not exist "%archivo%" (
    echo %USERNAME%>"%archivo%"
) else (
    :: Verifica si el usuario ya está en el archivo
    findstr /i "^%USERNAME%$" "%archivo%" >nul || echo %USERNAME%>>"%archivo%"
)

echo Usuario registrado en: %archivo%
endlocal
