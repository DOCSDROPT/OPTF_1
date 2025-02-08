# Obtenir le nombre de threads (processeurs logiques)
$THREADS = [Environment]::ProcessorCount

# Configurer BCD pour utiliser tous les threads
Start-Process -FilePath "bcdedit.exe" -ArgumentList "/set {current} numproc $THREADS" -Wait -NoNewWindow

# Obtenir le nombre de cœurs de processeur
$CORES = (Get-WmiObject -Class Win32_Processor).NumberOfCores

# Manipuler les clés de registre pour les périphériques USB
$USBDevices = Get-WmiObject -Query "SELECT DeviceID FROM Win32_PnPEntity WHERE DeviceID LIKE 'USB\\VID_%'" | Select-Object -ExpandProperty DeviceID

foreach ($DeviceID in $USBDevices) {
    $baseKey = "HKLM\SYSTEM\CurrentControlSet\Enum\$DeviceID\Device Parameters"

    # Créer les clés de registre si elles n'existent pas
    if (-not (Test-Path -Path "Registry::$baseKey")) {
        New-Item -Path "Registry::$baseKey" -Force
    }

    # Ajouter ou mettre à jour les valeurs de registre
    Set-ItemProperty -Path "Registry::$baseKey" -Name "EnhancedPowerManagementEnabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "Registry::$baseKey" -Name "AllowIdleIrpInD3" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "Registry::$baseKey" -Name "EnableSelectiveSuspend" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "Registry::$baseKey" -Name "DeviceSelectiveSuspended" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "Registry::$baseKey" -Name "SelectiveSuspendEnabled" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "Registry::$baseKey" -Name "SelectiveSuspendOn" -Value 0 -Type DWord -Force
    Set-ItemProperty -Path "Registry::$baseKey" -Name "D3ColdSupported" -Value 0 -Type DWord -Force
}

# Nettoyer et afficher les informations
Clear-Host
Write-Output "USB device registry configuration updated."
