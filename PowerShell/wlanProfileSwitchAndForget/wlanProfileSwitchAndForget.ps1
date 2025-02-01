# Ange primärt och sekundärt SSID, där det primära ska vara aktivt efter scriptet körts
$PrimarySSID = "REPLACEMENT-WLAN"
$SecondarySSID = "EXISTING-WLAN"

# Hämta en lista över alla kända WLAN-profiler på datorn
$WlanProfiles = netsh wlan show profiles | Select-String "All User Profile\s*:\s*(.+)" | ForEach-Object { $_.Matches.Groups[1].Value.Trim() }

# Kolla om de EXAKTA SSID:erna finns i listan
$HasPrimary = $WlanProfiles -contains $PrimarySSID
$HasSecondary = $WlanProfiles -contains $SecondarySSID

# Parametrar för loggning, används för att kunna söka i EventLog och synka till Intune
$LogName = "IT-WLAN-Management"
$Source = "WLANManager"

# Skapa eventloggen om den inte redan finns, så vi kan logga händelser kopplade till nätverksändringar
if (!(Get-EventLog -List | Where-Object { $_.Log -eq $LogName })) {
    New-EventLog -LogName $LogName -Source $Source
}

# Hämta det aktuella anslutna SSID:t
$CurrentSSID = (netsh wlan show interfaces | Select-String "SSID\s*:\s*(.+)").Matches.Groups[1].Value.Trim()
Write-Output "Datorn är ansluten till: $CurrentSSID"

# Logga aktuellt SSID i EventLog för spårbarhet
$EventID = 1004
$EventMessage = "Datorn är ansluten till SSID '$CurrentSSID'."
Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Information -Message $EventMessage

# Om datorn har "EXISTING-WLAN" men saknar "REPLACEMENT-WLAN" → Logga varning i EventLog
if ($HasSecondary -and -not $HasPrimary) {
    $EventID = 1002
    $EventMessage = "Varning: Datorn är ansluten till '$SecondarySSID' men saknar '$PrimarySSID'."
    Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Warning -Message $EventMessage
    Write-Output "Varning loggad: Saknar $PrimarySSID men har $SecondarySSID."
}
# Om båda nätverken finns → Försök att byta till det primära
elseif ($HasPrimary -and $HasSecondary) {
    Write-Output "Ansluter till $PrimarySSID..."
    netsh wlan connect name="$PrimarySSID"

    # Vänta några sekunder för att säkerställa att anslutningen sker
    Start-Sleep -Seconds 5
    $CurrentSSID = (netsh wlan show interfaces | Select-String "SSID\s*:\s*(.+)").Matches.Groups[1].Value.Trim()
    Write-Output "Efter anslutningsförsök: $CurrentSSID"

    # Kontrollera om bytet till det primära nätverket lyckades
    if ($CurrentSSID -eq $PrimarySSID) {
        # Radera det sekundära nätverket om det finns en exakt match
        Write-Output "Tar bort $SecondarySSID..."
        netsh wlan delete profile name="$SecondarySSID"

        # Logga att det sekundära SSID:t har glömts
        $EventID = 1001
        $EventMessage = "SSID '$SecondarySSID' har glömts efter anslutning till '$PrimarySSID'."
        Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Information -Message $EventMessage

        Write-Output "Processen är klar och loggad."
    } else {
        # Logga fel om anslutningen till det primära nätverket misslyckas och vilket SSID datorn är kvar på
        $EventID = 1003
        $EventMessage = "Fel: Kunde inte ansluta till '$PrimarySSID'. Datorn är kvar på '$CurrentSSID'."
        Write-EventLog -LogName $LogName -Source $Source -EventId $EventID -EntryType Error -Message $EventMessage

        Write-Output "Fel loggat: Kunde inte ansluta till $PrimarySSID. Datorn är kvar på $CurrentSSID."
    }
} else {
    # Inget att göra om nätverksprofiler saknas eller endast ett nätverk finns
    Write-Output "Nätverksprofiler saknas eller endast ett nätverk finns."
}