if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Veuillez executer ce script en tant qu administrateur." -ForegroundColor Red
    exit
}

$services = @(
    "wuauserv",        # Service Windows Update
    "UsoSvc",          # Service Update Orchestrator
    "WaaSMedicSvc"     # Service Windows Update Medic
)

foreach ($service in $services) {
    Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
    Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
}

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
$registryStorePath = "HKLM:\SOFTWARE\Microsoft\WindowsStore"

if (-NOT (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Set-ItemProperty -Path $registryPath -Name "NoAutoUpdate" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $registryPath -Name "AUOptions" -Value 1 -Type DWord -Force
Set-ItemProperty -Path $registryPath -Name "ScheduledInstallDay" -Value 0 -Type DWord -Force

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "DisableWindowsUpdateAccess" -Value 1 -Type DWord -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUServer" -Value "" -Type String -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "WUStatusServer" -Value "" -Type String -Force

gpupdate /force | Out-Null

Write-Host "Configuration terminée. Les mises a jour Windows sont desactivees." -ForegroundColor Green
