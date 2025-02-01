@'
# ange primärt och sekundärt SSID, primary är det som ska vara aktivt efter scriptet
$PrimarySSID = "LANN-Corporate"
$SecondarySSID = "LANN"

# hämta en lista över alla kända profiler
$WlanProfiles = netsh wlan show profiles | Select-String "All User Profile\s*:\s*(.+)" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }

# Kolla om det EXAKTA SSID:erna finns
$HasPrimary = $WlanProfiles -contains $PrimarySSID
$HasSecondary = $WlanProfiles -contains $SecondarySSID

# params för loggning så att man kan leta upp värdena i eventloggen och spegla dem till Intune
$LogName = "IT-WLAN-Management"
$Source = "WLANManager"

# skapa eventloggen om den inte finns uppsatt redan.
if (!(Get-EventLog -List | Where-Object { $_.Log -eq $LogName })) {
    New-EventLog -LogName $LogName -Source $Source
}

if ($HasSecondary -and -not $HasPrimary) {
    # Om datorn har "LANN" men saknar "LANN-Corporate", logga en varning
    $EventID = 1002
    $EventMessage = "Varning: Datorn är ansluten till '$SecondarySSID' men saknar '$PrimarySSID'."
    Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Warning -Message $EventMessage
    Write-Output "Varning loggad: Saknar $PrimarySSID men har $SecondarySSID."
}
elseif ($HasPrimary -and $HasSecondary) {
    # Försök ansluta till det primära nätverket
    Write-Output "Ansluter till $PrimarySSID..."
    netsh wlan connect name="$PrimarySSID"

    # Vänta tills anslutningen är etablerad
    Start-Sleep -Seconds 5
    $CurrentSSID = (netsh wlan show interfaces | Select-String "SSID\s*:\s*(.+)").Matches.Groups[1].Value.Trim()

    if ($CurrentSSID -eq $PrimarySSID) {
        # Ta bort det sekundära nätverket om det är en exakt match
        Write-Output "Tar bort $SecondarySSID..."
        netsh wlan delete profile name="$SecondarySSID"

        # Logga händelsen i EventLog
        $EventID = 1001
        $EventMessage = "SSID '$SecondarySSID' har glömts efter anslutning till '$PrimarySSID'."
        Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Information -Message $EventMessage

        Write-Output "Processen är klar och loggad."
    } else {
        # Om anslutning till "LANN-Corporate" misslyckas, logga ett fel
        $EventID = 1003
        $EventMessage = "Fel: Kunde inte ansluta till '$PrimarySSID'."
        Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Error -Message $EventMessage

        Write-Output "Fel loggat: Kunde inte ansluta till $PrimarySSID."
    }
} else {
    Write-Output "Nätverksprofiler saknas eller endast ett nätverk finns."
}
'@ | Set-Content -Path "$env:USERPROFILE\Desktop\WLAN-Manager.ps1" -Encoding UTF8