@echo off
reg.exe delete "HKLM\Software\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /f
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /f
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AutoInstallMinorUpdates" /f
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAUAsDefaultShutdownOption" /f
Reg.exe delete "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /f
Reg.exe delete "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /f
Reg.exe delete "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /f
Reg.exe delete "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\AudioDescription" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\Blind Access" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\HighContrast" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\Keyboard Preference" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\Keyboard Response" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\MouseKeys" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\On" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\ShowSounds" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\SlateLaunch" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\SoundSentry" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\StickyKeys" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\TimeOut" /f
Reg.exe delete "HKCU\Control Panel\Accessibility\ToggleKeys" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\AudioDescription" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\Blind Access" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\HighContrast" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\Keyboard Preference" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\Keyboard Response" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\MouseKeys" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\On" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\ShowSounds" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\SlateLaunch" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\SoundSentry" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\StickyKeys" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\TimeOut" /f
Reg.exe delete "HKU\.DEFAULT\Control Panel\Accessibility\ToggleKeys" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows\CurrentVersion\HotStart" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Sidebar" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Telephony" /f
Reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Screensavers" /f
Reg.exe delete "HKCU\Printers" /f
Reg.exe delete "HKLM\SYSTEM\ControlSet001\Control\Print" /f
Reg.exe delete "HKLM\SYSTEM\ControlSet002\Control\Print" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Boot\{304D2127-E6ED-4C82-B9B3-63B3B54A4D66}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Boot\{44AF7ADA-1C0D-43B1-A063-9E7581F7730B}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Logon\{88CE6B8C-B14B-499A-8D43-214F06116F07}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Logon\{892625FE-213B-4B60-95ED-A1CEFCAA365D}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{00446CF1-8668-472D-BEDD-D0BB88DBA009}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{117E2D01-1275-4560-90E9-A34BB4EE69A3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{57C76B66-AD3C-4221-81FA-55045859B06F}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{70EA2999-165C-4933-9027-250FB8B772F8}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{A2FADBDF-6855-42F7-BDFC-F0C510EDA9BC}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{C9EC268B-1D36-4AF0-A1EB-2C1BC3B455D9}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Maintenance\{F0FCA53B-F391-48AD-91F6-D1994846E55E}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{00446CF1-8668-472D-BEDD-D0BB88DBA009}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{117E2D01-1275-4560-90E9-A34BB4EE69A3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{2DFC28A5-3035-4555-A9E6-CE6D44EB1DB3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{309BA321-F7C8-46A4-BA50-5FAC484229CB}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{34ADEFE8-89DB-43BC-8C0B-14BB34D69F6D}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{3AB082DC-B77E-4487-BB5D-5DCB3A6C2B3C}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{3E51A991-10E2-4B16-B5B4-A2F051544BB9}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{3FC4BE91-4A96-48F5-8858-1628CB88EFB5}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{4671B5C1-A383-4428-A45A-8D348E4CB873}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{57C76B66-AD3C-4221-81FA-55045859B06F}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{6EF4AFAB-DF3D-467E-BB2C-66C7FDC9E4E7}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{70EA2999-165C-4933-9027-250FB8B772F8}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{82CE5325-8693-4EE3-BB57-939DC11EA637}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{87094343-6C1F-4855-A6B9-305BA74AB761}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{8FF5DE67-C947-4488-997B-4184221E7D50}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{90F68E39-00DE-4159-BCDB-5C5759A5CF53}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{9B29B882-A95C-438B-BF91-E7C31B1D82D1}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{A08D6A77-C926-4E78-9ED0-09836E2769AE}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{A2FADBDF-6855-42F7-BDFC-F0C510EDA9BC}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{C5D47392-881C-422A-9BF8-E4916B55CD22}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{C9EC268B-1D36-4AF0-A1EB-2C1BC3B455D9}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{EAD9ED20-AC69-4E97-8CCB-E8F62CA707B3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{EC3EFE4E-A2E4-4C66-975C-CA2EFD0D42CD}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{F0FCA53B-F391-48AD-91F6-D1994846E55E}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{00446CF1-8668-472D-BEDD-D0BB88DBA009}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{117E2D01-1275-4560-90E9-A34BB4EE69A3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{2DFC28A5-3035-4555-A9E6-CE6D44EB1DB3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{304D2127-E6ED-4C82-B9B3-63B3B54A4D66}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{309BA321-F7C8-46A4-BA50-5FAC484229CB}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{34ADEFE8-89DB-43BC-8C0B-14BB34D69F6D}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{3AB082DC-B77E-4487-BB5D-5DCB3A6C2B3C}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{3E51A991-10E2-4B16-B5B4-A2F051544BB9}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{3FC4BE91-4A96-48F5-8858-1628CB88EFB5}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{44AF7ADA-1C0D-43B1-A063-9E7581F7730B}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{4671B5C1-A383-4428-A45A-8D348E4CB873}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{57C76B66-AD3C-4221-81FA-55045859B06F}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{6EF4AFAB-DF3D-467E-BB2C-66C7FDC9E4E7}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{70EA2999-165C-4933-9027-250FB8B772F8}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{82CE5325-8693-4EE3-BB57-939DC11EA637}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{87094343-6C1F-4855-A6B9-305BA74AB761}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{88CE6B8C-B14B-499A-8D43-214F06116F07}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{892625FE-213B-4B60-95ED-A1CEFCAA365D}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{8FF5DE67-C947-4488-997B-4184221E7D50}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{90F68E39-00DE-4159-BCDB-5C5759A5CF53}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{9B29B882-A95C-438B-BF91-E7C31B1D82D1}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{A08D6A77-C926-4E78-9ED0-09836E2769AE}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{A2FADBDF-6855-42F7-BDFC-F0C510EDA9BC}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{C5D47392-881C-422A-9BF8-E4916B55CD22}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{C9EC268B-1D36-4AF0-A1EB-2C1BC3B455D9}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{EAD9ED20-AC69-4E97-8CCB-E8F62CA707B3}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{EC3EFE4E-A2E4-4C66-975C-CA2EFD0D42CD}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{F0FCA53B-F391-48AD-91F6-D1994846E55E}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\BitLocker" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\Chkdsk" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\Data Integrity Scan" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\DiskFootprint" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\InstallService" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\RecoveryEnvironment" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\Registry" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\SoftwareProtectionPlatform" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\TextServicesFramework" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\Report policies" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\USB" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\User Profile Service" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\WindowsUpdate\Scheduled Start" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Plain\{41F5FC9D-EE65-4CA4-A908-91B3587198E0}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{41F5FC9D-EE65-4CA4-A908-91B3587198E0}" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\XblGameSave" /f
Reg.exe delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Font Drivers" /v "Adobe Type Manager" /f
Reg.exe delete "HKLM\System\ControlSet001\Control\Terminal Server\Wds\rdpwd" /v "StartupPrograms" /f
Reg.exe delete "HKCR\Directory\background\shell\FoxOS. Made by CatGamerOP" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "legalnoticecaption" /f
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "legalnoticetext" /f
reg.exe delete "HKCU\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f
reg.exe delete "HKU\S-1-5-18\Software\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /f
reg.exe delete "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f
reg.exe delete "HKU\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Id" /f
reg.exe delete "HKLM\SYSTEM\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "ChangedInBootCycle" /f
reg.exe delete "HKLM\SYSTEM\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v "WasEnabledBy" /f
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /f
reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\ScheduledDiagnostics" /v "EnabledExecution" /f
Exit




















