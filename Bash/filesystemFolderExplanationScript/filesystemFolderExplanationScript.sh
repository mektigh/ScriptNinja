#!/bin/bash
#
# SCRIPT: filesystemFolderExplanationScript.sh
# AUTHOR: Mektigh
# DATE:   2025-02-02
# VERSION: 1.0
#
# DESCRIPTION:
#   Det här scriptet presenterar Linux/Unix-filsystemet på ett roligt
#   och gladare sätt i terminalen. Det förklarar varje viktig mapp
#   med humor och ANSI-färger för en trevligare upplevelse.
#
# USAGE:
#   1. Ge scriptet körbehörighet:
#      chmod +x filesystemFolderExplanationScript.sh
#   2. Kör scriptetdet:
#      ./filesystemFolderExplanationScript.sh
#
# OPTIONS:
#   --help  Visa hjälptext :P.
#   Inga argument behövs, men du kan anpassa färger och delay direkt
#   i scriptet genom att ändra variablerna.
#
# REQUIREMENTS:
#   - En Bash-kompatibel terminal
#   - ANSI-färgstödd terminal för bästa upplevelse
#
# NOTES:
#   - Skriptet är gjort för Mac & Linux.
#   - Windows-användare kan köra det via WSL (Windows Subsystem for Linux).
#
# LICENSE:
#   MIT License (se GitHub-repo för detaljer)

# Hantera --help och eventuellt andra kommandoradsargument
# Help-texten visas om användaren skriver --help
if [[ "$1" == "--help" ]]; then
    echo "Usage: $0"
    echo "  Detta skript presenterar Linux-filsystemet på ett roligt sätt!"
    echo "  Ingen konfiguration krävs."
    echo "  Alternativ:"
    echo "    --help  Visa denna hjälptext och avsluta."
    exit 0
fi

# ANSI färgkoder för snygg terminalutskrift
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
WHITE="\e[97m"
RESET="\e[0m"

# Funktion för att skriva ut varje rad med en liten delay
print_line() {
    echo -e "$1"
    sleep 0.3
}

clear

# En liten inledning
echo -e "${YELLOW}🌎 Välkommen till ditt Linux/Unix-filsystem! 📂${RESET}"
sleep 1
echo -e "${CYAN}Här är en guidad tur genom mapparna där magin händer... 🏰${RESET}\n"
sleep 1

print_line "${RED}/ -- The Root Directory 🌳"
print_line "   📌 Allt börjar här. Som en trädrot där alla filer grenar ut sig."
echo ""

print_line "${GREEN}/bin -- Essential User Binaries 🛠️"
print_line "   📌 Här bor viktiga kommandon som 'ls', 'cp' och 'rm'."
echo ""

print_line "${BLUE}/boot -- Static Boot Files 🚀"
print_line "   📌 Startfiler och kärnan bor här. Utan den? Ingen uppstart!"
echo ""

print_line "${MAGENTA}/cdrom -- CD-ROM Mount Point 💿"
print_line "   📌 Om du fortfarande använder CD-skivor, så monteras de här!"
echo ""

print_line "${CYAN}/dev -- Device Files ⚙️"
print_line "   📌 Specialfiler som representerar hårdvara, som din mus och hårddisk."
echo ""

print_line "${RED}/etc -- Configuration Files 📜"
print_line "   📌 Inställningar för allt! Servrar, nätverk och din favorit-terminal."
echo ""

print_line "${GREEN}/home -- Home Sweet Home 🏡"
print_line "   📌 Användarmapparna bor här. Dina filer, skrivbordet – allt!"
echo ""

print_line "${BLUE}/lib -- Essential Shared Libraries 📚"
print_line "   📌 Små kodbitar som program behöver för att fungera, typ som DLCs."
echo ""

print_line "${MAGENTA}/lost+found -- Recovered Files 🔍"
print_line "   📌 Om filsystemet kraschar, kan förlorade filer hittas här!"
echo ""

print_line "${CYAN}/media -- Removable Media 🎵"
print_line "   📌 USB-minnen och externa hårddiskar dyker upp här."
echo ""

print_line "${RED}/mnt -- Temporary Mount Points 🏗️"
print_line "   📌 En temporär plats för att montera enheter manuellt."
echo ""

print_line "${GREEN}/opt -- Optional Packages 🎁"
print_line "   📌 Extra programvara och tredjepartsapplikationer bor här."
echo ""

print_line "${BLUE}/proc -- Kernel & Process Files 🧠"
print_line "   📌 En magisk katalog som låtsas vara filer men egentligen är RAM-data."
echo ""

print_line "${MAGENTA}/root -- Root's Home Directory 👑"
print_line "   📌 Superanvändarens hem. Du får bara leka här om du är admin!"
echo ""

print_line "${CYAN}/run -- Application State Files 🔄"
print_line "   📌 Temporär data för systemets processer."
echo ""

print_line "${RED}/sbin -- System Administration Binaries 🏗️"
print_line "   📌 Som /bin, fast bara för systemadministratörer."
echo ""

print_line "${GREEN}/selinux -- SELinux Virtual File System 🔒"
print_line "   📌 En mystisk katalog för säkerhetshantering, om du har SELinux aktiverat."
echo ""

print_line "${BLUE}/srv -- Service Data 📦"
print_line "   📌 Här sparas data för tjänster, typ webbservrar."
echo ""

print_line "${MAGENTA}/tmp -- Temporary Files 🗑️"
print_line "   📌 Skräpkatalogen! Allt här raderas vid omstart."
echo ""

print_line "${CYAN}/usr -- User Binaries & Read-Only Data 💾"
print_line "   📌 Här bor extra program och systemfiler som inte ändras ofta."
echo ""

print_line "${RED}/var -- Variable Data Files 📊"
print_line "   📌 Loggar, mail, databaser – allt som ändras ofta sparas här."
echo ""

echo -e "\n${YELLOW}🎉 Grattis! Nu kan du navigera ditt Linux-filsystem som ett proffs! 🏆${RESET}"