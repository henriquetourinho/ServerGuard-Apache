#!/bin/bash

# Token do Bot no Telegram
BOT_TOKEN="SEU_BOT_TOKEN"

# Arquivo contendo os IDs dos chats (um por linha)
CHAT_IDS_FILE="/caminho/para/chat_ids.txt"

# Limites de Uso (em %)
CPU_LIMIT=80
MEMORY_LIMIT=90
DISK_LIMIT=90

# Função para enviar mensagem via Telegram
send_message() {
  local chat_id=$1
  local text=$2
  curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d "chat_id=${chat_id}" \
    -d "text=${text}" > /dev/null
}

# Função para verificar o uso de CPU
check_cpu_usage() {
  local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  echo $cpu_usage
}

# Função para verificar o uso de memória
check_memory_usage() {
  local memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
  echo $memory_usage
}

# Função para verificar o uso de disco
check_disk_usage() {
  local disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
  echo $disk_usage
}

# Função para verificar processos críticos (exemplo: Apache)
check_process() {
  local process_name=$1
  local process_count=$(ps aux | grep $process_name | grep -v grep | wc -l)
  echo $process_count
}

# Função para enviar alertas
send_alert() {
  local message=$1
  if [[ -f "$CHAT_IDS_FILE" ]]; then
    while IFS= read -r CHAT_ID; do
      if [[ -n "$CHAT_ID" ]]; then
        send_message "$CHAT_ID" "$message"
        echo "Mensagem enviada para o chat ID: $CHAT_ID"
      fi
    done < "$CHAT_IDS_FILE"
  else
    echo "Arquivo de IDs ($CHAT_IDS_FILE) não encontrado!"
    exit 1
  fi
}

# Verificar uso de CPU
CPU_USAGE=$(check_cpu_usage)
if (( $(echo "$CPU_USAGE > $CPU_LIMIT" | bc -l) )); then
  send_alert "Alerta: Uso de CPU está em ${CPU_USAGE}% (Acima de $CPU_LIMIT%)"
fi

# Verificar uso de memória
MEMORY_USAGE=$(check_memory_usage)
if (( $(echo "$MEMORY_USAGE > $MEMORY_LIMIT" | bc -l) )); then
  send_alert "Alerta: Uso de Memória está em ${MEMORY_USAGE}% (Acima de $MEMORY_LIMIT%)"
fi

# Verificar uso de disco
DISK_USAGE=$(check_disk_usage)
if (( DISK_USAGE > DISK_LIMIT )); then
  send_alert "Alerta: Uso de Disco está em ${DISK_USAGE}% (Acima de $DISK_LIMIT%)"
fi

# Verificar processo Apache (exemplo)
PROCESS_COUNT=$(check_process "apache2")
if (( PROCESS_COUNT == 0 )); then
  send_alert "Alerta: O processo Apache não está em execução!"
fi

echo "Monitoramento completo."

