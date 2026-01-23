#!/bin/bash
# Opis: Progream automatyzuje proces naprawy uszkodzonego pliku historii Zsh. Skrypt tworzy kopię zapasową, wyodrębnia czytelne dane i przywraca plik.

HISTORY_FILE="$HOME/.zsh_history"
BACKUP_FILE="$HOME/.zsh_history_bad"

echo "Rozpoczynanie naprawy pliku: $HISTORY_FILE"

# 1. Sprawdzenie czy plik historii istnieje
if [ ! -f "$HISTORY_FILE" ]; then
    echo "Błąd: Plik $HISTORY_FILE nie istnieje."
    exit 1
fi

# 2. Tworzenie kopii zapasowej
echo "Tworzenie kopii zapasowej do $BACKUP_FILE..."
mv "$HISTORY_FILE" "$BACKUP_FILE"

# 3. Naprawa pliku przy użyciu komendy strings
echo "Wyodrębnianie poprawnych wpisów..."
strings "$BACKUP_FILE" > "$HISTORY_FILE"

# 4. Przeładowanie historii w bieżącej sesji (opcjonalne w skrypcie)
fc -R .zsh_history

echo "Sukces! Plik historii został naprawiony."

rm $BACKUP_FILE
