FROM python:3.12-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock .
RUN uv sync --no-dev

COPY . .

RUN python manage.py collectstatic --noinput


FROM nginx:alpine

RUN apk add --no-cache python3 py3-pip && \
    pip install uv

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.12 /usr/local/lib/python3.12
COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /app /app

COPY nginx.conf /etc/nginx/nginx.conf

ENV DJANGO_SETTINGS_MODULE={{ project_name }}.config.settings \
    PYTHONUNBUFFERED=1

EXPOSE 80

CMD ["sh", "scripts/run.sh"]
