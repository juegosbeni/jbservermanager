@echo off
setlocal

set "JBSM_DIR=%LOCALAPPDATA%\JBSM"

if not exist "%JBSM_DIR%" (
    mkdir "%JBSM_DIR%"
)

cd /d "%JBSM_DIR%"

echo Comprobando Python...

python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python no encontrado. Instalando Python 3.12...

    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe -OutFile python_installer.exe"

    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1

    del python_installer.exe
)

echo Descargando instalador...

powershell -Command "Invoke-WebRequest -Uri https://github.com/juegosbeni/jbservermanager/releases/download/latest/JBSM_installer.py -OutFile JBSM_installer.py"

python JBSM_installer.py