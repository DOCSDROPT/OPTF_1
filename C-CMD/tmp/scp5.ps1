# Obtenir le nombre de threads (processeurs logiques)
$THREADS = [Environment]::ProcessorCount

# Configurer BCD pour utiliser tous les threads
Start-Process -FilePath "bcdedit.exe" -ArgumentList "/set {current} numproc $THREADS" -Wait -NoNewWindow

# Obtenir le nombre de cœurs de processeur
$CORES = (Get-WmiObject -Class Win32_Processor).NumberOfCores

# Rechercher les clés de registre contenant "StorPort" et modifier "EnableIdlePowerManagement"
$baseKey = "HKLM:\SYSTEM\CurrentControlSet\Enum"
$storPortKeys = Get-ChildItem -Path $baseKey -Recurse | Where-Object { $_.PSPath -like "*StorPort*" }

foreach ($key in $storPortKeys) {
    $keyPath = $key.PSPath -replace "Registry::", ""
    Set-ItemProperty -Path $keyPath -Name "EnableIdlePowerManagement" -Value 0 -Type DWord -Force
}

# Nettoyer et afficher les informations
Clear-Host
Write-Output "StorPort registry keys updated with EnableIdlePowerManagement=0."
