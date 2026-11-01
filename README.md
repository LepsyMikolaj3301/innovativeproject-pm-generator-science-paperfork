# PM Generator
Performance Management Generator project

## Local Development Setup (WSL + Docker Desktop)

### Prerequisites
- WSL2 with Ubuntu 22.04+
- Docker Desktop with WSL integration enabled
- VS Code with the Dev Containers extension

### Quick Start

1. **Open in VS Code:**
   ```bash
   code .
   ```

2. **Reopen in Container:**
   Press `Ctrl+Shift+P` → "Dev Containers: Rebuild and Reopen in Container"

3. **Start supporting services** (in a separate terminal):
   ```bash
   ./tools/bin/start_services.sh
   ```

4. **Start Airflow** (optional, in a separate terminal):
   ```bash
   ./tools/bin/start_airflow.sh
   ```

### Service URLs
| Service    | URL                    |
|------------|------------------------|
| Frontend   | http://localhost:5173  |
| FastAPI    | http://localhost:8000  |
| Keycloak   | http://localhost:8080  |
| MinIO      | http://localhost:9001  |
| Spark UI   | http://localhost:4040  |
| Jupyter    | http://localhost:4041  |
| Airflow    | http://localhost:9005  |

### Credentials
- **Keycloak:** admin / admin
- **MinIO:** minioadmin / minioadmin
- **Airflow:** airflow / airflow
- **Postgres:** genpm / genpm

## DAG management (Airflow proxy)

The web UI provides a modern, opinionated overlay on top of Apache Airflow 3.2.
Contract & data model: [`docs/architecture/dag-management.md`](docs/architecture/dag-management.md).

* Backend lives under `apps/backend/app/integrations/airflow/` (httpx async
  client, HS512 service-account JWT, retries with tenacity) and exposes
  REST + SSE under `/api/v1/dags/*`.
* Frontend lives under `apps/frontend/src/features/dags/` (Vue 3, Vue Flow
  + dagre auto-layout, Tailwind v4 + Reka UI, TanStack Vue Query for server
  state with adaptive polling).

### Dependencies
Backend FastAPI uses uv.

### How to add new dependencies to the project
```bash
# Runtime dependency:
docker exec genpm-fastapi sh -c "cd /app && uv add <package>"

# Dev dependency:
docker exec genpm-fastapi sh -c "cd /app && uv add --dev <package>"
```

### Ruff and MyPy scripts
Use simple scripts from bin:
- ./tools/bin/be_ruff.sh            # lint
- ./tools/bin/be_ruff.sh --fix      # lint + autofix
- ./tools/bin/be_mypy.sh
- ./tools/bin/be_verify.sh          # ruff + mypy
