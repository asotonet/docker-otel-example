#!/bin/bash

# URL de la API de órdenes
API_URL="http://localhost:3001/orders"

# Función para generar un ID de usuario aleatorio
generate_random_user_id() {
  echo "$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 24 | head -n 1)"
}

# Función para generar un ID de producto aleatorio
generate_random_product_id() {
  echo "$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w 24 | head -n 1)"
}

# Función para crear una orden aleatoria
create_random_order() {
  local user_id=$(generate_random_user_id)
  local product_id=$(generate_random_product_id)
  local quantity=$((RANDOM % 10 + 1))  # Cantidad aleatoria entre 1 y 10

  local order_data=$(jq -n \
    --arg user_id "$user_id" \
    --arg product_id "$product_id" \
    --argjson quantity "$quantity" \
    '{userId: $user_id, products: [{productId: $product_id, quantity: $quantity}]}')

  echo "Creando orden: $order_data"
  curl -X POST -H "Content-Type: application/json" -d "$order_data" "$API_URL"
  echo ""
}

# Función para obtener todas las órdenes
get_orders() {
  echo "Obteniendo órdenes..."
  curl -X GET "$API_URL"
  echo ""
}

# Función para actualizar el estado de una orden aleatoria
update_random_order_status() {
  local orders=$(curl -s -X GET "$API_URL")
  local order_ids=$(echo "$orders" | jq -r '.[]._id')

  if [[ -z "$order_ids" ]]; then
    echo "No hay órdenes para actualizar."
    return
  fi

  local order_id=$(echo "$order_ids" | shuf -n 1)
  local statuses=("paid" "cancelled" "shipped" "completed")
  local new_status="${statuses[$RANDOM % ${#statuses[@]}]}"

  echo "Actualizando orden $order_id a estado: $new_status"
  curl -X PATCH -H "Content-Type: application/json" -d "{\"status\": \"$new_status\"}" "$API_URL/$order_id"
  echo ""
}

# Bucle principal
while true; do
  create_random_order
  sleep 30  # Esperar 30 segundos antes de crear otra orden

  # Obtener órdenes cada 1 minuto
  if (( $(date +%s) % 60 == 0 )); then
    get_orders
  fi

  # Actualizar el estado de una orden aleatoria cada 2 minutos
  if (( $(date +%s) % 120 == 0 )); then
    update_random_order_status
  fi
done
