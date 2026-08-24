#!/bin/bash
# ============================================================
#  Import egg ke Pterodactyl Panel via Application API
#  Bisa dijalankan terpisah kapan saja (tidak perlu install ulang panel)
#  Dokumentasi API: https://dashflo.net/docs/api/pterodactyl/v1/
# ============================================================
set -e

EGG_FILE="./eggs/egg_tirzzganteng.json"

if [ ! -f "$EGG_FILE" ]; then
  echo "❌ File egg tidak ditemukan di $EGG_FILE"
  echo "   Pastikan kamu menjalankan script ini dari root folder repo."
  exit 1
fi

read -rp "URL panel (contoh: https://panel.domainmu.com): " PANEL_URL
read -rsp "Application API Key (rahasia, tidak akan ditampilkan): " API_KEY
echo ""
read -rp "Nest ID tujuan (lihat di Admin > Nests, default 1): " NEST_ID
NEST_ID=${NEST_ID:-1}

echo ""
echo "== Mengirim egg ke Nest #$NEST_ID di $PANEL_URL ... =="

HTTP_CODE=$(curl -s -o /tmp/egg_import_response.json -w "%{http_code}" \
  -X POST "${PANEL_URL%/}/api/application/nests/${NEST_ID}/eggs/import" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Accept: Application/vnd.pterodactyl.v1+json" \
  -F "file=@${EGG_FILE}")

if [ "$HTTP_CODE" == "204" ] || [ "$HTTP_CODE" == "201" ]; then
  echo "✅ Egg 'tirzzganteng' berhasil diimport ke Nest #$NEST_ID."
else
  echo "❌ Gagal import egg (HTTP $HTTP_CODE). Detail response:"
  cat /tmp/egg_import_response.json
  echo ""
  echo "Penyebab umum:"
  echo "  - API key salah / permission Nests-Eggs tidak dicentang"
  echo "  - Nest ID tidak ada (cek di Admin > Nests)"
  echo "  - URL panel salah / belum pakai https"
  exit 1
fi
