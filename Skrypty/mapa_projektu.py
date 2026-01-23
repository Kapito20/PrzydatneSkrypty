#!/usr/bin/env python3
import os
import platform
import sys

def is_hidden(filepath):
    """Sprawdza, czy plik lub folder jest ukryty (Linux/Windows)."""
    name = os.path.basename(filepath)
    if name.startswith('.'):
        return True
    if platform.system() == "Windows":
        try:
            import ctypes
            attrs = ctypes.windll.kernel32.GetFileAttributesW(filepath)
            return attrs != -1 and (attrs & 2)
        except:
            return False
    return False

def list_files(startpath):
    ignored_folders = {'.git', 'node_modules', '.idea', '.vscode', '__pycache__', 'dist', 'build'}
    
    # Normalizacja ścieżki do formy bezwzględnej dla czytelności nagłówka
    abs_startpath = os.path.abspath(startpath)
    print(f"STRUKTURA PROJEKTU: {abs_startpath}")
    print("-" * 30)

    for root, dirs, files in os.walk(startpath):
        # Pomijanie ignorowanych i ukrytych folderów
        dirs[:] = [d for d in dirs if d not in ignored_folders and not is_hidden(os.path.join(root, d))]
        
        level = root.replace(startpath, '').count(os.sep)
        indent = ' ' * 4 * level
        
        if root != startpath:
            print(f'{indent}📂 {os.path.basename(root)}/')
        
        subindent = ' ' * 4 * (level + 1)
        for f in sorted(files):
            if not is_hidden(os.path.join(root, f)):
                print(f'{subindent}📄 {f}')

if __name__ == '__main__':
    # Sprawdzenie czy podano argument ścieżki, w przeciwnym razie użyj '.' (PWD)
    target_path = sys.argv[1] if len(sys.argv) > 1 else '.'

    if not os.path.exists(target_path):
        print(f"Błąd: Ścieżka '{target_path}' nie istnieje.")
        sys.exit(1)

    try:
        list_files(target_path)
    except Exception as e:
        print(f"Wystąpił błąd: {e}")
    
    # Input tylko jeśli skrypt nie dostał argumentów (uruchomienie kliknięciem)
    if len(sys.argv) == 1:
        input("\nNaciśnij ENTER, aby zamknąć...")