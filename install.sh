#!/bin/bash
set -e

# ==============================================================================
# Script de Instalação: acer-aspire-bateria
# Autor: Nilson Oliveira (https://github.com/Mister-N-Oliveira)
# ==============================================================================

echo "=== Instalando Alternador de Limite de Bateria Acer ==="

# 1. Cria diretórios de destino no usuário se não existirem
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/icons/hicolor/scalable/apps"

# 2. Copia os arquivos
echo "-> Copiando script para ~/.local/bin/ ..."
cp alternar-bateria.sh "$HOME/.local/bin/alternar-bateria.sh"
chmod +x "$HOME/.local/bin/alternar-bateria.sh"

echo "-> Copiando ícone para ~/.local/share/icons/ ..."
cp icons/bateria-80-verde.svg "$HOME/.local/share/icons/hicolor/scalable/apps/bateria-80-verde.svg"

echo "-> Instalando atalho no menu de aplicativos..."
cp alternar-bateria.desktop "$HOME/.local/share/applications/alternar-bateria.desktop"

# 3. Configuração de sudoers (para alternar sem solicitar senha)
SUDOERS_FILE="/etc/sudoers.d/acer-battery-limit"
if [ ! -f "$SUDOERS_FILE" ]; then
    echo ""
    echo "Deseja configurar permissão sudo sem senha para alternar a bateria automaticamente? (Recomendado) [S/n]"
    read -r resp
    if [[ "$resp" =~ ^([sS]|[yY]|"")$ ]]; then
        echo "Configurando $SUDOERS_FILE (requer sudo)..."
        echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/tee /sys/bus/wmi/drivers/acer-wmi-battery/health_mode" | sudo tee "$SUDOERS_FILE" > /dev/null
        sudo chmod 0440 "$SUDOERS_FILE"
        echo "Permissão configurada com sucesso!"
    fi
fi

# 4. Atualiza os caches do sistema desktop
echo "-> Atualizando cache de ícones e aplicações..."
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
kbuildsycoca6 2>/dev/null || kbuildsycoca5 2>/dev/null || true

echo ""
echo "=== Instalação concluída com sucesso! ==="
echo "Você já pode encontrar o atalho 'Alternar Limite Bateria (80% / 100%)' no menu do seu sistema."
