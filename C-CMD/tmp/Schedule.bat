@echo off
cls
sc config "Schedule" start=disabled
sc config "WSearch" start=disabled
sc config "SysMain" start=disabled
sc config "AMD Crash Defender Service" start=disabled
sc config "AMD External Events Utility" start=disabled
@timeout /t 02>nul
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettings /t REG_DWORD /d "0" /f
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d "3" /f
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverrideMask /t REG_DWORD /d "3" /f
rem del /f /q "%WinDir%\System32\mcupdate_GenuineIntel.dll"
rem del /f /q "%WinDir%\System32\mcupdate_AuthenticAMD.dll"
Exit