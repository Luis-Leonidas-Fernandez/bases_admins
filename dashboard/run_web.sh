#!/bin/bash

# Verifica el argumento recibido
if [ "$1" == "dev" ]; then
  ENV_FILE=".env.dev"
elif [ "$1" == "prod" ]; then
  ENV_FILE=".env.prod"
else
  echo "❌ Uso: ./run_web.sh [dev|prod]"
  exit 1
fi

# Ejecuta Flutter con el archivo .env correspondiente
flutter run -d chrome --dart-define-from-file=$ENV_FILE


