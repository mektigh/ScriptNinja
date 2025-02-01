# WLAN Profile Switch and Forget

## Beskrivning
Detta skript hanterar trådlösa nätverksprofiler på Windows-enheter.
Funktioner:
- Kollar om datorn har nätverken **"Wi-Fi OLD"** och **"Wi-Fi NEW"**.
- Om båda finns, ansluter den till **"WI-Fi NEW"** och tar bort **"Wi-Fi OLD"**.
- Loggar alla relevanta händelser (som lyckade åtgärder, fel och varningar) i en anpassad EventLog.

@> **ℹ️ Viktig information**  
> Skriptet loggar olika Event ID i en anpassad EventLog för att hålla reda på aktiviteter, vilket gör det möjligt att övervaka processen via Intune.  
> Se till att anpassa SSID-namnen i skriptet efter dina nätverksinställningar. @

## Redigera SSID:
Om du behöver ändra SSID-namnen, gör det genom att justera följande variabler i skriptet:
```powershell
$PrimarySSID = "WI-Fi NEW"
$SecondarySSID = "Wi-Fi OLD"
```

## Så här kör du processen i terminalen:
1. Öppna PowerShell som administratör.
2. Kör kommandon:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force

.\C:\Windows\Temp\WLAN\wlanProfileSwitchAndForget.ps1
```
**Om du kör från github eller annan webplats**
```powershell
Invoke-WebRequest -Uri "https://github.com/mektigh/TheScriptNinja/wlanProfileSwitchAndForget.ps1" -OutFile "C:\Windows\Temp\WLAN\wlanProfileSwitchAndForget.ps1"
```
```powershell
powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\WLAN\wlanProfileSwitchAndForget.ps1"
```

---

### Vad gör du nu:
- Se till att skriptet finns i **C:\Windows\Temp\WLAN\**.
- Följ instruktionerna i denna README-fil för att köra skriptet, implementera det i Intune eller Group Policy.

Om något behöver justeras eller om du har frågor, hör av dig!
