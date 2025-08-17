FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential tzdata && rm -rf /var/lib/apt/lists/*

COPY backend/pyproject.toml backend/poetry.lock* /app/
RUN pip install --no-cache-dir poetry && poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

COPY backend/ /app/

ENV TZ=${APP_TZ:-America/Los_Angeles}

# Use Railway's PORT if provided
CMD bash -lc 'uvicorn src.main:app --host 0.0.0.0 --port ${PORT:-8000}'
