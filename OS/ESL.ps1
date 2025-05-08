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

$SystemMemoryListInformation = 0x50
$MemoryPurgeStandbyList       = 4

Write-Host " "
Write-Host "   60   /  1  Min   |   660   /  11 Min   |   1260  /  21 Min"
Write-Host "   120  /  2  Min   |   720   /  12 Min   |   1320  /  22 Min"
Write-Host "   180  /  3  Min   |   780   /  13 Min   |   1380  /  23 Min"
Write-Host "   240  /  4  Min   |   840   /  14 Min   |   1440  /  24 Min"
Write-Host "   300  /  5  Min   |   900   /  15 Min   |   1500  /  25 Min"
Write-Host "   360  /  6  Min   |   960   /  16 Min   |   1560  /  26 Min"
Write-Host "   420  /  7  Min   |   1020  /  17 Min   |   1620  /  27 Min"
Write-Host "   480  /  8  Min   |   1080  /  18 Min   |   1680  /  28 Min"
Write-Host "   540  /  9  Min   |   1140  /  19 Min   |   1740  /  29 Min"
Write-Host "   600  /  10 Min   |   1200  /  20 Min   |   1800  /  30 Min"
Write-Host " "
$interval = Read-Host "Intervalle entre chaque purge (en secondes) "
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
