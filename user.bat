@echo off
setlocal enabledelayedexpansion

:: Ruta del archivo en la misma carpeta que el script
set "archivo=%~dp0_us.txt"

:: Lista de usuarios a agregar
set "usuarios=%USERNAME% Public"

:: Si el archivo no existe, lo crea
if not exist "%archivo%" (
    > "%archivo%" (
        for %%u in (%usuarios%) do echo %%u
    )
) else (
    for %%u in (%usuarios%) do (
        findstr /i "^%%u$" "%archivo%" >nul || echo %%u>>"%archivo%"
    )
)

echo Usuarios registrados en: %archivo%
endlocal
