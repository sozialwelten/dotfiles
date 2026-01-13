# Systemdateien
Persönliche Systemkonfigurationsdateien und Backup wichtiger Einstellungen.

## Inhalt
- `persdict.dat` - Firefox persönliches Wörterbuch
- `bash_aliases` - Bash-Aliase und Shortcuts
- `.vimrc` - Vim-Konfiguration mit Plugins
- `nixos/` - NixOS System-Konfiguration

## Verwendung

### NixOS-Konfiguration

**Installation auf neuem NixOS System:**
```bash
# Repo klonen
cd ~
git clone git@github.com:sozialwelten/dotfiles.git

# Symlink zur System-Config erstellen
sudo ln -sf ~/dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix

# System neu bauen
sudo nixos-rebuild switch
```

**Änderungen vornehmen:**
```bash
# Config bearbeiten
vim ~/dotfiles/nixos/configuration.nix

# System neu bauen
sudo nixos-rebuild switch

# Änderungen committen
cd ~/dotfiles
git add nixos/
git commit -m "Update NixOS configuration"
git push
```

**Hinweis:** Die `hardware-configuration.nix` ist gerätespezifisch. Bei neuem Gerät die vorhandene `/etc/nixos/hardware-configuration.nix` behalten oder anpassen.

### Firefox Wörterbuch wiederherstellen
```bash
cp persdict.dat ~/.mozilla/firefox/XXXXXXXX.default/
```

### Bash-Aliase aktivieren
```bash
cp bash_aliases ~/.bash_aliases
source ~/.bashrc
```

### Vim-Konfiguration installieren
```bash
# 1. vim-plug Plugin Manager installieren
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 2. .vimrc kopieren
cp .vimrc ~/.vimrc

# 3. Vim öffnen und Plugins installieren
vim
:PlugInstall
# Vim neu starten
```

## Vim-Konfiguration

### Features
- Hybrid Zeilennummerierung (absolute + relative)
- Maus-Unterstützung & System-Zwischenablage
- Persistentes Undo
- Python-optimiert (PEP 8, 4 Spaces)
- Dunkles Theme (skull-vim)
- File Explorer (NERDTree)
- Git-Integration (Fugitive, GitGutter)
- Auto-Close Klammern

### Wichtigste Keybindings
**Leader Key = Space**

| Keybinding | Aktion |
|------------|--------|
| `Space + w` | Speichern |
| `Space + e` | File Explorer toggle |
| `Space + f` | Dateisuche (wenn fzf installiert) |
| `Space + b` | Buffer-Liste |
| `gcc` | Zeile kommentieren |
| `Ctrl + h/j/k/l` | Zwischen Splits navigieren |

### Plugins
- **skull-vim** - Theme
- **vim-airline** - Statusleiste
- **NERDTree** - File Explorer
- **fzf.vim** - Fuzzy Finder (optional)
- **vim-fugitive** - Git-Integration
- **vim-commentary** - Kommentieren
- **vim-surround** - Klammern/Quotes bearbeiten
- **auto-pairs** - Auto-Close
- **ALE** - Python Linting (optional)
- **vim-polyglot** - Multi-Language Support

### Optionale Tools (für volle Funktionalität)

**FZF & Ripgrep** (bessere Dateisuche):
```bash
sudo apt install fzf ripgrep  # Debian/Ubuntu
brew install fzf ripgrep      # macOS
```

**Python Linting/Formatting** (ALE Support):
```bash
pip install flake8 pylint black isort
```

Ohne diese Tools funktioniert Vim trotzdem - du verlierst nur Fuzzy-Finding (`Space + f`) und Python-Linting.

### Vim-Befehle für Anfänger
```vim
:w              " Speichern
:q              " Beenden
:wq             " Speichern & Beenden
:PlugInstall    " Plugins installieren
:PlugUpdate     " Plugins aktualisieren
```

---
*Letzte Aktualisierung: Januar 2025*
