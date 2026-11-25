# acer-aspire-bateria 🔋

> Utilitário simples e prático para alternar o limite de carregamento da bateria entre **80% (Modo Conservação)** e **100% (Modo Viagem)** em notebooks Acer no Linux.

Inclui notificação visual nativa no desktop e atualização dinâmica do ícone no menu do sistema e barra de tarefas.

---

## 📋 Pré-requisitos

Este projeto depende do driver de kernel **`acer-wmi-battery`** para controlar o limiar de carga (`health_mode`).

### Instalação do driver (Arch Linux / Manjaro):
```bash
yay -S acer-wmi-battery-dkms
```
*(Ou compile/instale a partir do repositório upstream caso utilize Fedora, Ubuntu ou Debian).*

Verifique se o módulo está ativo:
```bash
cat /sys/bus/wmi/drivers/acer-wmi-battery/health_mode
```
Se retornar `1` ou `0`, seu hardware é totalmente compatível!

---

## 🚀 Instalação Rápida

Clone o repositório e execute o script de instalação:

```bash
git clone https://github.com/Mister-N-Oliveira/acer-aspire-bateria.git
cd acer-aspire-bateria
chmod +x install.sh
./install.sh
```

O instalador irá:
1. Copiar o script principal para `~/.local/bin/alternar-bateria.sh`.
2. Instalar o ícone personalizado SVG em `~/.local/share/icons/hicolor/scalable/apps/`.
3. Criar o atalho no menu de aplicativos do seu sistema (`~/.local/share/applications/alternar-bateria.desktop`).
4. (Opcional) Configurar regra no `sudoers` para permitir a troca do limite sem exigir senha no terminal todas as vezes.

---

## 💡 Como Usar

- **Pelo menu de aplicativos:** Busque por **"Alternar Limite Bateria"** no lançador do seu desktop (KDE, GNOME, XFCE, etc.) e clique para alternar.
- **Pelo terminal:**
  ```bash
  alternar-bateria.sh
  ```
- **Por atalho de teclado:** Você pode vincular o comando `~/.local/bin/alternar-bateria.sh` a qualquer tecla de atalho nas configurações do seu sistema operacional.

---

## 🗑️ Desinstalação

Para remover completamente:
```bash
chmod +x uninstall.sh
./uninstall.sh
```

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

Desenvolvido por [Nilson Oliveira](https://github.com/Mister-N-Oliveira).
