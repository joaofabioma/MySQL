@echo off
REM exit
cls
set "PATHROOT=%~dp0"
echo ================================
echo  Instalando servico MySQL 8.4.6
echo ================================

REM NOME DO SERVIÇO
set SERVICE_NAME=MySQL

REM CAMINHO DO MYSQLD
REM set MYSQLD_PATH="%USERPROFILE%\develop\mysql846\bin\mysqld.exe"
REM OU
set MYSQLD_PATH="%PATHROOT%\bin\mysqld.exe"

REM REMOVER SERVIÇO SE JÁ EXISTIR
sc query %SERVICE_NAME% >nul 2>&1
if %errorlevel%==0 (
    echo Servico %SERVICE_NAME% já existe. Removendo...
    sc stop %SERVICE_NAME% >nul 2>&1
	"%MYSQLD_PATH%" --remove
    sc delete %SERVICE_NAME%
)

echo Criando serviço...
"%MYSQLD_PATH%" --install --defaults-file=%MYSQLD_PATH%\my.cnf

echo Iniciando serviço...
sc start %SERVICE_NAME%

echo ================================
echo  Servico instalado e iniciado!
echo ================================
pause