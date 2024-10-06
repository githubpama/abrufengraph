# Azure Info Script

Dieses Skript sammelt und zeigt verschiedene Informationen aus Ihrer Azure-Umgebung an, einschließlich Benutzerinformationen, Lizenzen, Intune- und Defender-Konfigurationen sowie eine Übersicht der Azure-Ressourcen.

## Voraussetzungen

- Bash-Shell
- Azure CLI (az command)
- jq (JSON processor)
- Gültige Azure-Anmeldeinformationen mit den erforderlichen Berechtigungen

## Funktionen

Das Skript enthält folgende Hauptfunktionen:

1. `get_access_token()`: Authentifiziert und erhält ein Zugriffstoken für Microsoft Graph API.
2. `get_users_info_table()`: Ruft Benutzerinformationen ab und stellt sie tabellarisch dar.
3. `get_licenses()`: Zeigt verfügbare Lizenzen und deren Nutzung an.
4. `get_configurations()`: Listet Intune-Gerätekonfigurationen und Defender-Richtlinien auf.
5. `get_azure_resources()`: Gibt eine Übersicht der Azure-Ressourcen aus.

## Verwendung

1. Stellen Sie sicher, dass Sie alle Voraussetzungen erfüllt haben.
2. Speichern Sie das Skript als `azure_info.sh`.
3. Machen Sie das Skript ausführbar: `chmod +x azure_info.sh`
4. Führen Sie das Skript aus: `./azure_info.sh`

## Hinweis

Dieses Skript erfordert entsprechende Berechtigungen in Ihrer Azure-Umgebung. Stellen Sie sicher, dass Ihr Azure-Konto über die notwendigen Rechte verfügt, um auf die angeforderten Informationen zuzugreifen.

## Beitrag

Fühlen Sie sich frei, Verbesserungen vorzuschlagen oder Probleme zu melden, indem Sie Issues oder Pull Requests in diesem Repository erstellen.

## Lizenz

[Fügen Sie hier Ihre gewünschte Lizenzinformation ein]
