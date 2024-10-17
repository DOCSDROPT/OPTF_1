@echo off
@Title START-UP
set black=[30m
set red=[91m
set rred=[41m
set green=[32m
set ggreen=[42m
set yellow=[33m
set yyellow=[43m
set blue=[34m
set bblue=[44m
set magenta=[35m
set bmagenta=[45m
set cyan=[36m
set defcolor=[49m
set gold=[38;5;220m
set grey=[90m
set ggrey=[100m
set orange=[38;5;208m
set white=[37m
set indigo=[38;5;105m
set iindigo=[48;5;105m
color 7
cls

rmdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
mkdir %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
if %errorlevel% neq 0 (
	cls
	echo Veuillez executer le CMD en tant qu'administrateur.
	pause
	exit
)

if /i "%~1"=="/4" (
	mode con:cols=80 lines=27
) else (
	Start "" /b C:\Windows\System32\conhost.exe "STARTUP.bat" /4&exit
)

IF NOT EXIST %APPDATA%\LSTRP\config.bat goto :firststart
:firststartback
C:
cd %APPDATA%\LSTRP
call config.bat

:MAINW
IF NOT EXIST 7za.exe curl -g -k -L -# -o "7za.exe" "https://tinyurl.com/dl-opt-7za" >nul 2>&1
mode con:cols=80 lines=27
cd %APPDATA%\LSTRP
cls
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
echo  %bblue% OS : Windows %BLD% %defcolor%%iindigo% ID : %HWID% %defcolor%
echo ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
echo ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
echo ³  ÚÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿  ³
echo ³  ³ %indigo%[1]%white% ³ Windows Activation                                               ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[2]%white% ³ dControl                                                         ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[3]%white% ³ Optimisation                                              %gold%[BETA]%white% ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[4]%white% ³ MSI Utility V3                                                   ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[5]%white% ³ WPD                                                              ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[6]%white% ³ Autoruns                                                         ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[7]%white% ³ Device Cleanup                                                   ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[8]%white% ³ CCleaner                                                         ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[9]%white% ³ Dism++                                                           ³  ³
echo ³  ÃÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´  ³
echo ³  ³ %indigo%[0]%white% ³ Edge Remover                                                     ³  ³
echo ³  ÀÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  ³
echo ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
set /p CSTARTR="%green%>%white%"
If "%CSTARTR%"=="1" (
	curl -g -k -L -# -o "MAS_AIO.cmd" "https://raw.githubusercontent.com/massgravel/Microsoft-Activation-Scripts/master/MAS/Separate-Files-Version/Activators/HWID_Activation.cmd" >nul 2>&1
	start cmd /c "MAS_AIO.cmd"
	goto :MAINW
)
If "%CSTARTR%"=="2" (
	IF EXIST dControl.exe START dControl.exe&goto :MAINW
	curl -g -k -L -# -o "dControl.exe" "https://tinyurl.com/DEFDCONT" >nul 2>&1
	START dControl.exe
	goto :MAINW
)
If "%CSTARTR%"=="3" (
	IF EXIST BETA-Optifiles.7z DEL BETA-Optifiles.7z>nul
	curl -g -k -L -# -o "BETA-Optifiles.7z" "https://tinyurl.com/53496874098" >nul 2>&1
	@timeout /t 10>nul
	IF EXIST BETA-Optifiles.7z (7za.exe -y x -p9421 -oC:\ BETA-Optifiles.7z >nul)
	IF EXIST 7za.exe DEL 7za.exe>nul
	IF EXIST BETA-Optifiles.7z DEL BETA-Optifiles.7z>nul
	IF EXIST C:\ph_main.exe start C:\ph_main.exe
	goto :MAINW
)
If "%CSTARTR%"=="4" (
	IF NOT EXIST "MSI" md "MSI"
	IF NOT EXIST "MSI\PCIutil.exe" curl -g -k -L -# -o "MSI\PCIutil.exe" "https://tinyurl.com/357876356" >nul 2>&1
	IF NOT EXIST "MSI\MSI_util_v3.exe" curl -g -k -L -# -o "MSI\MSI_util_v3.exe" "https://tinyurl.com/87846765756" >nul 2>&1
	START "" "MSI\PCIutil.exe"
	@timeout /t 02>nul
	Taskkill /f /im PCIutil.exe>nul
	START "" "MSI\MSI_util_v3.exe"
	goto :MAINW
)
If "%CSTARTR%"=="5" (
	IF EXIST WPD.exe START WPD.exe&goto :MAINW
	curl -g -k -L -# -o "WPD.exe" "https://tinyurl.com/673652456452" >nul 2>&1
	START WPD.exe
	goto :MAINW
)
If "%CSTARTR%"=="6" (
	IF EXIST Autoruns.exe START Autoruns.exe&goto :MAINW
	curl -g -k -L -# -o "Autoruns.exe" "https://tinyurl.com/7i76u56376365" >nul 2>&1
	START Autoruns.exe
	goto :MAINW
)
If "%CSTARTR%"=="7" (
	IF EXIST DeviceCleanup.exe START DeviceCleanup.exe&goto :MAINW
	curl -g -k -L -# -o "DeviceCleanup.exe" "https://tinyurl.com/86357658785" >nul 2>&1
	START DeviceCleanup.exe
	goto :MAINW
)
If "%CSTARTR%"=="8" (
	IF EXIST "CCleaner\CCleaner\CCleaner64.exe" START "" "CCleaner\CCleaner\CCleaner64.exe"&goto :MAINW
	IF NOT EXIST "CCleaner" md "CCleaner"
	IF EXIST "CCleaner.7z" DEL "CCleaner.7z" >nul
	curl -g -k -L -# -o "CCleaner.7z" "https://tinyurl.com/657358753673685" >nul 2>&1
	IF EXIST CCleaner.7z (7za.exe -y x -p9421 -o"CCleaner" CCleaner.7z >nul)
	START "" "CCleaner\CCleaner\CCleaner64.exe"
	goto :MAINW
)
If "%CSTARTR%"=="9" (
	IF EXIST "Dism\Dism++x64.exe" START "" "Dism\Dism++x64.exe"&goto :MAINW
	IF NOT EXIST "Dism" md "Dism"
	IF EXIST "DismInstall.7z" DEL "DismInstall.7z" >nul
	curl -g -k -L -# -o "DismInstall.7z" "https://tinyurl.com/645665875763" >nul 2>&1
	IF EXIST DismInstall.7z (7za.exe -y x -o"Dism" DismInstall.7z >nul)
	START "" "Dism\Dism++x64.exe"
	goto :MAINW
)
If "%CSTARTR%"=="0" (
	curl -g -k -L -# -o "Remove-EdgeWeb.exe" "https://github.com/ShadowWhisperer/Remove-MS-Edge/raw/main/Remove-EdgeWeb.exe" >nul 2>&1
	@timeout /t 01>nul
	START Remove-EdgeWeb.exe
	goto :MAINW
)
goto :MAINW
:firststart
IF NOT EXIST %APPDATA%\LSTRP md %APPDATA%\LSTRP
for /f "tokens=*" %%i in ('powershell "Get-WmiObject Win32_BaseBoard | Select-Object -ExpandProperty SerialNumber"') do SET "HWID=%%i"
PowerShell -Command "Get-AppxPackage *WindowsTerminal* | Remove-AppxPackage" >nul 2>&1
echo SET HWID=%HWID%>%APPDATA%\LSTRP\config.bat
for /f "tokens=3" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild') do set build_number=%%i
if %build_number% GEQ 22000 (
    SET WVAC=11
) else if %build_number% GEQ 10240 (
    SET WVAC=10
) else (
    SET WVAC=ERR
)
Echo SET BLD=%WVAC%>>%APPDATA%\LSTRP\config.bat
goto :firststartback