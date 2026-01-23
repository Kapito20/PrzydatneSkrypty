#!/bin/bash
# Opis: Program automatyzuje klonowanie repozytoriów Git przy użyciu tokenu Personal Access Token (PAT). Skrypt wstrzykuje token do adresu URL i pozwala na opcjonalne zdefiniowanie ścieżki docelowej.
# Użycie: ./git-clone-token.sh <URL_REPOZYTORIUM> <SCIEZKA_DOCELOWA (Opcjonalne)>


# --- KONFIGURACJA ---
PATH_TO_TOKEN="/home/kali/Desktop/Config/token.txt"

# --- LOGIKA ---
REPO_URL=$1
TARGET_DIR=$2


if [ -z "$REPO_URL" ] || [ ! -f "$PATH_TO_TOKEN" ]; then
    echo "Błąd: Brak adresu URL lub plik z tokenem nie istnieje."
    exit 1
fi

TOKEN=$(tr -d '[:space:]' < "$PATH_TO_TOKEN")
CLEAN_URL=${REPO_URL#https://}

# Klonowanie do PWD lub wskazanej ścieżki
if [ -z "$TARGET_DIR" ]; then
    git clone "https://$TOKEN@$CLEAN_URL"
else
    git clone "https://$TOKEN@$CLEAN_URL" "$TARGET_DIR"
fi
