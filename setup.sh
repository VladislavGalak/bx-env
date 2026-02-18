#!/usr/bin/env bash
# ===========================================
# Установка Ansible и зависимостей
# ===========================================
set -euo pipefail

echo "=== Установка зависимостей для Ansible ==="

# Установка pip и venv
sudo apt update
sudo apt install -y python3-pip python3.12-venv

# Создание виртуального окружения
python3 -m venv "$(dirname "$0")/.venv"
source "$(dirname "$0")/.venv/bin/activate"

# Установка Ansible
pip install ansible

echo ""
echo "=== Ansible установлен ==="
ansible --version
echo ""
echo "Для использования активируйте окружение:"
echo "  source $(dirname "$0")/.venv/bin/activate"
echo ""
echo "Затем разверните проект:"
echo "  cd $(dirname "$0")"
echo "  ansible-playbook deploy.yml -e \"@projects/np.yml\""


