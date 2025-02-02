$dirs = @(
    @{ Path = "/"; Description = "The Root Directory" }
    @{ Path = "/bin"; Description = "Essential User Binaries" }
    @{ Path = "/boot"; Description = "Static Boot Files" }
    @{ Path = "/cdrom"; Description = "Historical Mount Point for CD-ROMs" }
    @{ Path = "/dev"; Description = "Device Files" }
    @{ Path = "/etc"; Description = "Configuration Files" }
    @{ Path = "/home"; Description = "Home Folders" }
    @{ Path = "/lib"; Description = "Essential Shared Libraries" }
    @{ Path = "/lost+found"; Description = "Recovered Files" }
    @{ Path = "/media"; Description = "Removable Media" }
    @{ Path = "/mnt"; Description = "Temporary Mount Points" }
    @{ Path = "/opt"; Description = "Optional Packages" }
    @{ Path = "/proc"; Description = "Kernel & Process Files" }
    @{ Path = "/root"; Description = "Root Home Directory" }
    @{ Path = "/run"; Description = "Application State Files" }
    @{ Path = "/sbin"; Description = "System Administration Binaries" }
    @{ Path = "/selinux"; Description = "SELinux Virtual File System" }
    @{ Path = "/srv"; Description = "Service Data" }
    @{ Path = "/tmp"; Description = "Temporary Files" }
    @{ Path = "/usr"; Description = "User Binaries & Read-Only Data" }
    @{ Path = "/var"; Description = "Variable Data Files" }
)

# Funktion för att skriva ut text i färg
function Write-ColorText {
    param(
        [string]$Text,
        [string]$Color
    )
    Write-Host $Text -ForegroundColor $Color
}

# ASCII-header
Write-ColorText "LINUX FILE SYSTEM STRUCTURE" "Cyan"
Write-ColorText "--------------------------------" "Cyan"

# Skriv ut kataloger med färg och struktur
foreach ($dir in $dirs) {
    Write-ColorText ("$($dir.Path) → $($dir.Description)") "Green"
    Start-Sleep -Milliseconds 200  # Lägger till en liten fördröjning för effekt
}

Write-ColorText "\nDone! 🎉" "Yellow"
