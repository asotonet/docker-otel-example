#!/bin/bash

# URL de la API
API_URL="http://user:3004/users"

# Función para generar un nombre aleatorio
generate_random_name() {
  local names=("Alice" "Bob" "Charlie" "David" "Eva" "Frank" "Grace" "Henry" "Ivy" "Jack")
  echo "${names[$((RANDOM % ${#names[@]}))]}"
}

# Función para generar un correo electrónico aleatorio
generate_random_email() {
  local domains=("example.com" "test.com" "demo.com" "fake.com")
  local random_string=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
  local domain="${domains[$((RANDOM % ${#domains[@]}))]}"
  echo "${random_string}@${domain}"
}

# Función para crear un usuario aleatorio
create_random_user() {
  local name=$(generate_random_name)
  local email=$(generate_random_email)
  local user_data=$(jq -n --arg name "$name" --arg email "$email" '{name: $name, email: $email}')

  echo "Creando usuario: $user_data"
  curl -X POST -H "Content-Type: application/json" -d "$user_data" "$API_URL"
  echo ""
}

# Función para obtener todos los usuarios
get_users() {
  echo "Obteniendo usuarios..."
  curl -X GET "$API_URL"
  echo ""
}

# Bucle principal
while true; do
  create_random_user
  sleep 30  # Esperar 30 segundos antes de crear otro usuario

  # Obtener usuarios cada 1 minuto
  if (( $(date +%s) % 60 == 0 )); then
    get_users
  fi
done
