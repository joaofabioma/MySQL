@echo off
REM exit
cls
set "PATHROOT=%~dp0"
set "PATHBIN=%PATHROOT%bin\"
set "PATHDATA=%PATHROOT%data\master\\"

REM rm -f -r -d "%PATHDATA%"
(%CD:~0,2%&(mkdir "%PATHDATA%" 2> NUL))&

cd %PATHBIN%
if not exist "%PATHDATA%" md "%PATHDATA%"
del /f /q /s "%PATHROOT%start.cmd"
del /f /q /s "%PATHROOT%stop.cmd"

echo [mysqld]>"%PATHROOT%my.cnf"
echo user=root>>"%PATHROOT%my.cnf"
echo basedir=%PATHROOT:\=/%>>"%PATHROOT%my.cnf"
echo datadir=%PATHDATA:\=/%>>"%PATHROOT%my.cnf"
echo lc-messages=pt_BR>>"%PATHROOT%my.cnf"
REM echo lc-messages-dir=%PATHROOT%\share\\portuguese\\>>"%PATHROOT%my.cnf"

%PATHBIN%mysqld --initialize-insecure --console --user=root --datadir="%PATHDATA:\=/%" --basedir="%PATHROOT:\=/%"

takeown /F "%PATHDATA%" /R /D Y
echo %PATHROOT%
icacls "%PATHDATA%" /grant "Todos":F /T /C /Q
icacls "%PATHDATA%" /grant "Administradores":F /T /C /Q
echo Permissoes configuradas com sucesso!
cd ..
echo @echo off>"%PATHROOT%start.cmd"
echo @echo off>"%PATHROOT%stop.cmd"

REM echo "%PATHBIN%mysqld">>"%PATHROOT%start.cmd"
echo start /B "" "%PATHBIN%mysqld.exe" --console>>"%PATHROOT%start.cmd"
echo "%PATHBIN%mysqladmin.exe" -u root shutdown>>"%PATHROOT%stop.cmd"
