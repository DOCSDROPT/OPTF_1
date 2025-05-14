#Requires -RunAsAdministrator

Add-Type @"
using System;
using System.Diagnostics;
using System.Runtime.InteropServices;

public class PriorityUtils {
    [DllImport("ntdll.dll")]
    public static extern uint NtSetInformationProcess(
        IntPtr hProcess,
        int processInformationClass,
        ref int processInformation,
        uint processInformationLength
    );

    public static void SetPriority(Process process, int priorityClass) {
        try {
            NtSetInformationProcess(
                process.Handle,
                0x1B, // ProcessBasePriority
                ref priorityClass,
                sizeof(int)
            );
        }
        catch { /* Gestion native des erreurs */ }
    }
}
"@

$processNames = @("Spotify", "simplewall", "cmd", "explorer","Spotify", "waterfox", "firefox", "chrome","opera", "steam", "steamwebhelper", "rare","MicrosoftEdgeUpdate", "Edge", "EmptyStandbyList", "ESL","EpicGamesLauncher", "BakkesMod", "EpicOnlineServices", "EpicOnlineServicesHost","EpicWebHelper", "vlc", "Update", "Discord","wallpaper32", "updater", "7zFM", "7z","Authy Desktop", "Optimizer", "Services", "RLBotGUIX","StartAllBackCfg", "UpdateCheck", "streamlink", "streamlinkw","streamlink-twitch-gui", "Cheat Engine", "cheatengine-i386", "cheatengine-x86_64","cheatengine-x86_64-SSE4-AVX2", "StartUP", "WinMemoryCleaner", "AdguardPortable","AdguardSvc", "Adguard.BrowserExtensionHost", "Adguard", "Adguard.Tools","certutil", "maintenancetool", "SteelSeriesGG", "SteelSeriesUpdateService","SteelSeriesGGClient", "SSHZExecutor", "SSOverlay", "SteelSeriesEngine","win_driver_installer", "computerhardwareids", "spoolsv", "spaceman","spaceutil", "Spectrum", "sort", "SpaceAgent","slui", "dwm", "audiodg", "Taskmgr","ntprint", "csrss", "ctfmon", "svchost","WmiPrvSE", "notepad", "RuntimeBroker", "dllhost","sppsvc", "wallpaperservice32_c", "ui32", "SetTimerResolutionService","vmms", "lsass", "Magnify", "lusrmgr","manage-bde", "winlogon", "winload", "wininit","WindowsUpdateElevatedInstaller", "smss", "sihost", "ntoskrnl","lghub_updater", "lghub_uninstaller", "lghub_agent", "lghub","logi_crashpad_handler", "lghub_system_tray", "librewolf", "gamingservices", "wgc", "OpenHardwareMonitor")

foreach ($name in $processNames) {
    Get-Process -Name $name -ErrorAction SilentlyContinue | ForEach-Object {
        try {
            # Méthode 1 : Standard .NET
            $_.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::BelowNormal
            
            # Méthode 2 : API Windows native (si la première échoue)
            [PriorityUtils]::SetPriority($_, 8) # 8 = BelowNormal
            
            # Vérification forcée
            $_.Refresh()
            
            if($_.PriorityClass -ne 'BelowNormal') {
                Write-Warning "Échec critique pour $($_.ProcessName) (PID $($_.Id))"
                $_.Kill() # Optionnel : redémarrage forcé (à utiliser avec prudence)
                Start-Process -FilePath $_.Path -WindowStyle Hidden
            }
        }
        catch {
            # Méthode 3 : Utilisation de WMI
            $wmiProcess = Get-WmiObject Win32_Process -Filter "ProcessId = $($_.Id)"
            $wmiProcess.SetPriority(16384) # 16384 = BelowNormal
        }
    }
}

# Vérification approfondie
Get-WmiObject Win32_Process | Where-Object { 
    $processNames -contains $_.Name.Split('.')[0] 
} | Select-Object Name, ProcessId, Priority |
Format-Table -AutoSize
