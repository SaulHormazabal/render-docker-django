# {{ project_name }}

Template para proyecto Django desplegados en Render.

## Descripción

Este es un template de proyecto Django configurado para ser desplegado en Render usando Docker. Incluye configuración de Nginx como proxy reverso y está optimizado para producción.

## Estructura del Proyecto

```
{{ project_name }}/
├── {{ project_name }}/
│   ├── apps/                 # Aplicaciones Django
│   └── config/               # Configuración del proyecto
│       ├── settings.py       # Configuración Django
│       ├── urls.py          # URLs principales
│       ├── wsgi.py          # Configuración WSGI
│       └── asgi.py          # Configuración ASGI
├── scripts/
│   ├── deploy.sh            # Script de despliegue
│   └── run.sh               # Script de ejecución
├── manage.py                # Comando de administración Django
├── Dockerfile               # Configuración Docker
├── docker-compose.yaml      # Configuración para desarrollo local
├── nginx.conf               # Configuración Nginx
└── pyproject.toml           # Dependencias del proyecto
```

## Requisitos

- Python 3.12+
- UV (gestor de paquetes)
- Docker (para despliegue)

## Instalación

### Desarrollo Local

1. Clona el repositorio:
```bash
git clone <tu-repositorio>
cd {{ project_name }}
```

2. Instala las dependencias usando UV:
```bash
uv sync
```

3. Aplica las migraciones:
```bash
python manage.py migrate
```

4. Ejecuta el servidor de desarrollo:
```bash
python manage.py runserver
```

### Con Docker Compose (Desarrollo)

1. Configura las variables de entorno creando un archivo `.env`:
```env
DATABASE_NAME=mydb
DATABASE_USER=myuser
DATABASE_PASSWORD=mypassword
DATABASE_PORT=5432
REDIS_PORT=6379
```

2. Ejecuta los servicios:
```bash
docker-compose up -d
```

## Despliegue en Render

### Configuración

1. Conecta tu repositorio a Render
2. Configura las siguientes variables de entorno en Render:
   - `DJANGO_SETTINGS_MODULE={{ project_name }}.config.settings`
   - `SECRET_KEY` (genera una clave secreta segura)
   - `DEBUG=False`
   - `ALLOWED_HOSTS` (incluye tu dominio de Render)

### Build y Deploy

El proyecto incluye scripts automatizados:

- **Deploy Script** ([`scripts/deploy.sh`](scripts/deploy.sh)): Ejecuta migraciones y recolecta archivos estáticos
- **Run Script** ([`scripts/run.sh`](scripts/run.sh)): Inicia Gunicorn y Nginx

## Configuración

### Settings

La configuración principal se encuentra en [`{{ project_name }}/config/settings.py`]({{ project_name }}/config/settings.py):

- Base de datos: SQLite por defecto (configurable para PostgreSQL)
- Idioma: Español (Chile)
- Zona horaria: UTC
- Archivos estáticos: Configurados para producción

### URLs

Las URLs principales están definidas en [`{{ project_name }}/config/urls.py`]({{ project_name }}/config/urls.py). Actualmente incluye:

- `/admin/` - Panel de administración Django

### Nginx

La configuración de Nginx ([`nginx.conf`](nginx.conf)) incluye:

- Servir archivos estáticos desde `/static/`
- Servir archivos media desde `/media/`
- Proxy reverso para la aplicación Django

## Comandos Útiles

```bash
# Crear superusuario
python manage.py createsuperuser

# Hacer migraciones
python manage.py makemigrations

# Aplicar migraciones
python manage.py migrate

# Recolectar archivos estáticos
python manage.py collectstatic

# Ejecutar tests
python manage.py test
```

## Tecnologías Utilizadas

- **Django 5.2+** - Framework web
- **Python 3.12** - Lenguaje de programación
- **UV** - Gestor de paquetes Python
- **Gunicorn** - Servidor WSGI
- **Nginx** - Servidor web y proxy reverso
- **Docker** - Containerización
- **PostgreSQL** - Base de datos (opcional)
- **Redis** - Cache y broker (opcional)
