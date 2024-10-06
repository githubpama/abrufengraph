#!/bin/bash

# Funktion zur Authentifizierung und Token-Erhalt
get_access_token() {
    az account get-access-token --resource https://graph.microsoft.com | jq -r .accessToken
}

# Benutzer mit Name, Vorname und Rechten/Gruppen/Rollen abrufen und als Tabelle darstellen
get_users_info_table() {
    local token=$1
    echo "Benutzerinformationen (Tabellarisch):"
    echo "+-----------------+-----------------+------------------------------+------------------------+"
    echo "| Vorname         | Nachname        | E-Mail                       | Gruppen/Rollen         |"
    echo "+-----------------+-----------------+------------------------------+------------------------+"
    curl -s -H "Authorization: Bearer $token" \
         "https://graph.microsoft.com/v1.0/users?\$select=givenName,surname,userPrincipalName&\$expand=memberOf" | \
    jq -r '.value[] | [.givenName // "", .surname // "", .userPrincipalName // "", (.memberOf | map(.displayName) | join(", ") // "")] | 
        "| \(.[0] | .[0:15] | . + " "*(15-length)) | \(.[1] | .[0:15] | . + " "*(15-length)) | \(.[2] | .[0:28] | . + " "*(28-length)) | \(.[3] | .[0:22] | . + " "*(22-length)) |"'
    echo "+-----------------+-----------------+------------------------------+------------------------+"
}

# Lizenzen abrufen und als Tabelle darstellen
get_licenses() {
    local token=$1
    echo "Verfügbare Lizenzen:"
    echo "+------------------------------------------+----------------+---------------------+"
    echo "| Lizenzname                              | Gesamtanzahl   | Zugewiesene Anzahl  |"
    echo "+------------------------------------------+----------------+---------------------+"
    curl -s -H "Authorization: Bearer $token" \
         "https://graph.microsoft.com/v1.0/subscribedSkus" | \
    jq -r '.value[] | 
        "| \(.skuPartNumber | .[0:40] | . + " "*(40-length)) | \(.prepaidUnits.enabled | tostring | .[0:14] | . + " "*(14-length)) | \(.consumedUnits | tostring | .[0:18] | . + " "*(18-length)) |"'
    echo "+------------------------------------------+----------------+---------------------+"
}

# Intune und Defender Konfigurationen abrufen
get_configurations() {
    local token=$1
    echo "Intune und Defender Konfigurationen:"
    
    echo "Intune Gerätekonfigurationen:"
    curl -s -H "Authorization: Bearer $token" \
         "https://graph.microsoft.com/v1.0/deviceManagement/deviceConfigurations" | \
    jq -r '.value[] | "- \(.displayName // "N/A")"' || echo "Keine Konfigurationen gefunden oder Zugriff verweigert."
    
    echo -e "\nDefender Richtlinien:"
    curl -s -H "Authorization: Bearer $token" \
         "https://graph.microsoft.com/v1.0/security/securityActions" | \
    jq -r '.value[] | "- \(.name // "N/A")"' || echo "Keine Richtlinien gefunden oder Zugriff verweigert."
}

# Azure Ressourcen abrufen
get_azure_resources() {
    echo "Azure Ressourcen Übersicht:"
    az resource list --output table || echo "Keine Ressourcen gefunden oder Zugriff verweigert."
}

# Hauptfunktion
main() {
    local token=$(get_access_token)
    
    get_users_info_table "$token"
    echo -e "\n"
    get_licenses "$token"
    echo -e "\n"
    get_configurations "$token"
    echo -e "\n"
    get_azure_resources
}

# Skript ausführen
main
