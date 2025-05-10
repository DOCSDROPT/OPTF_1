<#
.SYNOPSIS
    Purge périodique de la Standby List via NtSetSystemInformation.

.DESCRIPTION
    Lance une boucle infinie qui purge la standby list toutes les X secondes.
    Peut être démarré :
      • en passant -Interval <secondes> en ligne de commande, ou
      • sans argument pour saisir l’intervalle à l’invite.

.EXAMPLE
    .\PurgeStandby.ps1 -Interval 15

    Purge toutes les 15 secondes sans invite.
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [double] $Interval
)

function Get-Interval {
    param($prompt)
    do {
        $input = Read-Host $prompt
    } until ([double]::TryParse($input, [ref]$null) -and [double]$input -gt 0)
    return [double]$input
}

# Si pas d'argument, on invite
if (-not $PSBoundParameters.ContainsKey('Interval')) {
    $Interval = Get-Interval "Intervalle entre chaque purge (en secondes)"
}

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

Write-Host "`nPurge de la standby list toutes les $Interval secondes. Ctrl+C pour stopper.`n"

while ($true) {
    $ptr = [Runtime.InteropServices.Marshal]::AllocHGlobal(4)
    [Runtime.InteropServices.Marshal]::WriteInt32($ptr, $MemoryPurgeStandbyList)
    [NativeMethods]::NtSetSystemInformation(
        $SystemMemoryListInformation,
        $ptr,
        4
    ) | Out-Null
    [Runtime.InteropServices.Marshal]::FreeHGlobal($ptr)
    Start-Sleep -Seconds $Interval
}
