@echo off
mode con lines=30 cols=60
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
:main
cls
color 2f
echo.-----------------------------------------------------------
echo.��ѡ��ʹ�ã�
echo.
echo. 1.����ȫ��
echo.
echo. 2.list.dat ����
echo.-----------------------------------------------------------

if exist "%SystemRoot%\System32\choice.exe" goto Win7Choice

set /p choice=���������ֲ����س���ȷ��:

echo.
if %choice%==1 goto create list
if %choice%==2 goto update
cls
"set choice="
echo ����������������ѡ��
goto main

:Win7Choice
choice /c 12 /n /m "��������Ӧ���֣�"
if errorlevel 2 goto update
if errorlevel 1 goto create list
cls
goto main

:create list
dir *. /b >list.dat
:update
@(for /f %%a in (list.dat) do @( if exist %%a @( pushd %%a && cd >>../log.txt && cd && git fetch --all >>../log.txt && git reset --hard origin/master >>../log.txt && npm i >>../log.txt && popd )))&&(if exist list.dat del list.dat /f /q)&&(if exist log.txt del log.txt /f /q)
goto end

:end
echo �밴������˳���
@Pause>nul
