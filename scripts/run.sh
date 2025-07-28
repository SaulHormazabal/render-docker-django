gunicorn {{ project_name }}.config.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 & \
  nginx -g 'daemon off;'
