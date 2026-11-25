#!/bin/bash
# ==============================================================================
# Script: alternar-bateria.sh
# Descrição: Alterna o limite de carregamento da bateria (80% / 100%) em
#            notebooks Acer utilizando o driver acer-wmi-battery.
# Autor: Nilson Oliveira (https://github.com/Mister-N-Oliveira)
# ==============================================================================

ARQUIVO="/sys/bus/wmi/drivers/acer-wmi-battery/health_mode"
DESKTOP="$HOME/.local/share/applications/alternar-bateria.desktop"

# Verifica se o driver está carregado
if [ ! -f "$ARQUIVO" ]; then
    notify-send -u critical -i dialog-error "Erro - Limite de Bateria" "Driver acer-wmi-battery não encontrado em /sys/bus/wmi/drivers/acer-wmi-battery/health_mode"
    exit 1
fi

ATUAL=$(cat "$ARQUIVO")

if [ "$ATUAL" = "1" ]; then
    # Desativa o limite de 80% -> Permite carregar até 100%
    echo 0 | sudo tee "$ARQUIVO" > /dev/null
    if [ -f "$DESKTOP" ]; then
        sed -i 's/^Icon=.*/Icon=battery-full-charging/' "$DESKTOP"
    fi
    notify-send -i battery-full-charging "Limite da Bateria: 100%" "Modo viagem ativado. O notebook carregará até a carga máxima."
else
    # Ativa o limite de 80% -> Modo Conservação
    echo 1 | sudo tee "$ARQUIVO" > /dev/null
    if [ -f "$DESKTOP" ]; then
        sed -i 's/^Icon=.*/Icon=bateria-80-verde/' "$DESKTOP"
    fi
    notify-send -i bateria-80-verde "Limite da Bateria: 80%" "Modo conservação ativado. Carregamento limitado a 80%."
fi

# Atualiza caches do ambiente desktop para refletir a troca de ícone
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
kbuildsycoca6 2>/dev/null || kbuildsycoca5 2>/dev/null || true
