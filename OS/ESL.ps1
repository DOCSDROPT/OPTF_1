# Nécessite d'être lancé en tant qu'Administrateur

# Import de la signature NtSetSystemInformation
$signature = @"
using System;
using System.Runtime.InteropServices;
public class NativeMethods {
    [DllImport("ntdll.dll")]
    public static extern int NtSetSystemInformation(
        int SystemInformationClass,
        IntPtr SystemInformation,
        int SystemInformationLength
    );
}
"@

Add-Type $signature

# Constantes
$SystemMemoryListInformation = 0x50
$MemoryPurgeStandbyList       = 4

# Lecture de l'intervalle
$interval = Read-Host "Intervalle entre chaque purge (en secondes)"
if (-not ([double]::TryParse($interval, [ref]$null)) -or [double]$interval -le 0) {
    Write-Error "Intervalle invalide"
    exit
}

Write-Host "Purge de la standby list toutes les $interval secondes. Ctrl+C pour stopper.`n"

while ($true) {
    $ptr = [System.Runtime.InteropServices.Marshal]::AllocHGlobal(4)
    [System.Runtime.InteropServices.Marshal]::WriteInt32($ptr, $MemoryPurgeStandbyList)
    $res = [NativeMethods]::NtSetSystemInformation(
        $SystemMemoryListInformation,
        $ptr,
        4
    )
    [System.Runtime.InteropServices.Marshal]::FreeHGlobal($ptr)
    Start-Sleep -Seconds $interval
}
