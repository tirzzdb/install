#!/bin/bash
# ============================================================
#  Pterodactyl Panel Installer + Auto Egg Import
#  - Install panel pakai installer RESMI komunitas
#    (https://github.com/pterodactyl-installer/pterodactyl-installer)
#  - Setelah panel jadi, otomatis import eggs/egg_tirzzganteng.json
# ============================================================
set -e

if [ "$EUID" -ne 0 ]; then
  echo "❌ Jalankan script ini sebagai root (sudo ./install.sh)"
  exit 1
fi

echo "=========================================="
echo "  STEP 1: Install Pterodactyl Panel"
echo "=========================================="
echo "Menjalankan installer resmi komunitas pterodactyl-installer..."
bash <(curl -s https://pterodactyl-installer.se)

echo ""
echo "=========================================="
echo "  STEP 2: Import Egg ke Panel"
echo "=========================================="
echo "Sebelum lanjut, buat Application API Key dulu:"
echo "  1. Login ke panel > Admin Area > Application API"
echo "  2. Buat key baru, permission minimal: Nests (Read/Write), Eggs (Read/Write)"
echo ""

./import-egg.sh
