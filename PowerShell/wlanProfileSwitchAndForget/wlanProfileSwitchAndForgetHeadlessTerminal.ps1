@'
$PrimarySSID = "WI-Fi NEW"
$SecondarySSID = "WI-FI OLD"

$WlanProfiles = netsh wlan show profiles | Select-String "All User Profile\s*:\s*(.+)" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }

$HasPrimary = $WlanProfiles -contains $PrimarySSID
$HasSecondary = $WlanProfiles -contains $SecondarySSID

$LogName = "IT-WLAN-Management"
$Source = "WLANManager"

if (!(Get-EventLog -List | Where-Object { $_.Log -eq $LogName })) {
    New-EventLog -LogName $LogName -Source $Source
}

$CurrentSSID = (netsh wlan show interfaces | Select-String "SSID\s*:\s*(.+)").Matches.Groups[1].Value.Trim()
Write-Output "Datorn är ansluten till: $CurrentSSID"

$EventID = 1004
$EventMessage = "Datorn är ansluten till SSID '$CurrentSSID'."
Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Information -Message $EventMessage

if ($HasSecondary -and -not $HasPrimary) {
    $EventID = 1002
    $EventMessage = "Varning: Datorn är ansluten till '$SecondarySSID' men saknar '$PrimarySSID'."
    Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Warning -Message $EventMessage
    Write-Output "Varning loggad: Saknar $PrimarySSID men har $SecondarySSID."
}

elseif ($HasPrimary -and $HasSecondary) {
    Write-Output "Ansluter till $PrimarySSID..."
    netsh wlan connect name="$PrimarySSID"
    Start-Sleep -Seconds 5
    $CurrentSSID = (netsh wlan show interfaces | Select-String "SSID\s*:\s*(.+)").Matches.Groups[1].Value.Trim()
    Write-Output "Efter anslutningsförsök: $CurrentSSID"
    if ($CurrentSSID -eq $PrimarySSID) {
        Write-Output "Tar bort $SecondarySSID..."
        netsh wlan delete profile name="$SecondarySSID"
        $EventID = 1001
        $EventMessage = "SSID '$SecondarySSID' har glömts efter anslutning till '$PrimarySSID'."
        Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Information -Message $EventMessage
        Write-Output "Processen är klar och loggad."
    } else {
        $EventID = 1003
        $EventMessage = "Fel: Kunde inte ansluta till '$PrimarySSID'. Datorn är kvar på '$CurrentSSID'."
        Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Error -Message $EventMessage
        Write-Output "Fel loggat: Kunde inte ansluta till $PrimarySSID. Datorn är kvar på $CurrentSSID."
    }
} else {
    Write-Output "Nätverksprofiler saknas eller endast ett nätverk finns."
}
'@ | Set-Content -Path "C:\Windows\Temp\WLAN\wlanProfileSwitchAndForget.ps1" -Encoding UTF8