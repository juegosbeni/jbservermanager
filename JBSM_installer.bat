@echo off
title JB Server Manager Installer
setlocal EnableDelayedExpansion

echo.
echo ==========================================
echo       JB Server Manager Installer
echo ==========================================
echo.

REM --------------------------------------------------
REM BUSCAR PYTHON
REM --------------------------------------------------

python --version >nul 2>&1

if errorlevel 1 (
echo No tienes Python instalado o la version es antigua.
echo.
echo Para usar JB Server Manager necesitas tener Python.
echo.
echo A continuacion se instalara Python.
echo.

```
choice /C SN /M "Quieres continuar"

if errorlevel 2 (
    echo.
    echo Necesitas Python para usar JB Server Manager.
    echo.
    pause
    exit /b
)

echo.
echo Abre esta pagina y descarga la ultima version:
echo https://www.python.org/downloads/
echo.
echo IMPORTANTE:
echo Marca "Add Python to PATH" durante la instalacion.
echo.
pause

python --version >nul 2>&1

if errorlevel 1 (
    echo.
    echo Python sigue sin estar disponible.
    pause
    exit /b
)
```

)

echo.
echo El programa se instalara en:
echo %APPDATA%\JBServerManager
echo.

choice /C SN /M "Quieres continuar"

if errorlevel 2 exit /b

REM --------------------------------------------------
REM CREAR DIRECTORIO
REM --------------------------------------------------

set "INSTALL_DIR=%APPDATA%\JBServerManager"

if not exist "%INSTALL_DIR%" (
mkdir "%INSTALL_DIR%"
)

REM --------------------------------------------------
REM DESCARGAR INSTALLER
REM --------------------------------------------------

echo.
echo Descargando instalador...
echo.

powershell -NoProfile -ExecutionPolicy Bypass ^
-Command "Invoke-WebRequest 'https://github.com/juegosbeni/jbservermanager/releases/download/latest/JBSM_installer.py' -OutFile '%INSTALL_DIR%\JBSM_installer.py'"

if errorlevel 1 (
echo.
echo Error al descargar JBSM_installer.py
pause
exit /b
)

echo.
echo Instalacion preparada.
echo.

REM --------------------------------------------------
REM EJECUTAR INSTALLER EN ESTA MISMA CONSOLA
REM --------------------------------------------------

python "%INSTALL_DIR%\JBSM_installer.py" "%~f0"

exit /b
