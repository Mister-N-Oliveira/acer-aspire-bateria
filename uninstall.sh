#!/bin/bash
set -e

# ==============================================================================
# Script de Desinstalação: acer-aspire-bateria
# Autor: Nilson Oliveira (https://github.com/Mister-N-Oliveira)
# ==============================================================================

echo "=== Desinstalando Alternador de Limite de Bateria Acer ==="

rm -f "$HOME/.local/bin/alternar-bateria.sh"
rm -f "$HOME/.local/share/applications/alternar-bateria.desktop"
rm -f "$HOME/.local/share/icons/hicolor/scalable/apps/bateria-80-verde.svg"

if [ -f "/etc/sudoers.d/acer-battery-limit" ]; then
    echo "Removendo regra do sudoers..."
    sudo rm -f "/etc/sudoers.d/acer-battery-limit"
fi

update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
kbuildsycoca6 2>/dev/null || kbuildsycoca5 2>/dev/null || true

echo "=== Desinstalação concluída! ==="
