
# WLAN Manager Script

## Beskrivning
Detta skript hanterar trådlösa nätverksprofiler på Windows-enheter. Här är vad det gör:
- Kollar om datorn har nätverken "LANN" och "LANN-Corporate".
- Om båda finns, ansluter den till "LANN-Corporate" och tar bort "LANN".
- Loggar alla relevanta händelser (som lyckade åtgärder, fel och varningar) i en anpassad EventLog.

## Viktig information
@> **ℹ️ Information:**  
> Skriptet loggar olika Event ID i en anpassad EventLog för att hålla reda på aktiviteter, vilket gör det möjligt att övervaka processen via Intune.  
> Se till att anpassa SSID-namnen i skriptet efter dina nätverksinställningar. @

### Redigera SSID:
Om du behöver ändra SSID-namnen, gör det genom att justera följande variabler i skriptet:
```powershell
$PrimarySSID = "LANN-Corporate"
$SecondarySSID = "LANN"
```

## Så här kör du processen i terminalen:
1. Öppna PowerShell som administratör.
2. Kör följande kommando:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
Invoke-WebRequest -Uri "https://example.com/path/to/WLAN_Manager.ps1" -OutFile "C:\Windows\Temp\WLAN\WLAN_Manager.ps1"
powershell -ExecutionPolicy Bypass -File "C:\Windows\Temp\WLAN\WLAN_Manager.ps1"
```

## Implementering i Intune:
@> **⚠️ Varning:**  
> När du laddar upp skriptet till Intune, se till att det är korrekt format för att undvika att det inte körs som förväntat. Felaktig uppladdning kan orsaka att skriptet inte körs på enheterna. @

1. Ladda upp skriptet i Intune under **Devices > Scripts**.
2. Skapa en ny PowerShell-scriptpolicy och välj **WLAN_Manager.ps1**.
3. Applicera policyn på de användargrupper eller enheter du vill köra skriptet på.

## Lägg till skriptet i Group Policy (GPO) på en DC:
@> **💡 Tips:**  
> För att lägga till skriptet i Group Policy, se till att det körs under rätt användarkonfiguration och att inga restriktioner hindrar PowerShell-skript. @

1. Öppna **Group Policy Management**.
2. Skapa en ny GPO för att köra PowerShell-skriptet.
3. Under **User Configuration > Windows Settings > Scripts**, välj att lägga till skriptet **"WLAN_Manager.ps1"**.

## Alternativa metoder:
@> **❌ Fel:**  
> Om enheten inte har ett trådlöst nätverkskort eller om det är inaktiverat, kommer skriptet att misslyckas och logga ett felmeddelande. @

- Du kan också köra detta skript som en del av en uppgift i systemhanteringslösningar som SCCM eller andra hanteringsverktyg.

---

### Vad gör du nu:
- Se till att skriptet finns i **C:\Windows\Temp\WLAN\**.
- Följ instruktionerna i denna README-fil för att köra skriptet, implementera det i Intune eller Group Policy.

Om något behöver justeras eller om du har frågor, hör av dig!
