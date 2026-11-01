#!/bin/bash
# Start supporting services for local development.
# The devcontainer (Spark) starts automatically via VS Code.
# Airflow is optional — run tools/bin/start_airflow.sh separately.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

cd "$REPO_ROOT"

# Create .env from template if missing
if [ ! -f .env ]; then
  cp .env.template .env
  echo "Created .env from .env.template — edit as needed."
fi

# Build and start services
docker compose --env-file .env -f infra/docker-compose.yml up -d --build

echo ""
echo "Services started:"
echo "  Frontend:  http://localhost:5173"
echo "  FastAPI:   http://localhost:8000"
echo "  Keycloak:  http://localhost:8080"
echo "  MinIO:     http://localhost:9001 (console)"
echo "  MinIO API: http://localhost:9000"
echo "  Postgres:  localhost:5432"
