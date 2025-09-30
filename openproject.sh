[Unit]
Description=OpenProject Docker Container
Documentation=https://www.openproject.org/docs/
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/opt/openproject

# Création des répertoires s'ils n'existent pas
ExecStartPre=mkdir -p /var/lib/openproject/pgdata
ExecStartPre=mkdir -p /var/lib/openproject/assets
ExecStartPre=mkdir -p /var/lib/openproject/logs
ExecStartPre=chown -R 1000:1000 /var/lib/openproject/

# Démarrage du container
ExecStart=/usr/bin/docker run \
  --name openproject \
  -p 8080:80 \
  -e OPENPROJECT_SECRET_KEY_BASE=secret \
  -e OPENPROJECT_HOST__NAME=openproject.apps.ocp.heritage.africa \
  -e OPENPROJECT_HTTPS=false \
  -e OPENPROJECT_EMAIL__DELIVERY__METHOD=:smtp \
  -e OPENPROJECT_EMAIL__SMTP__ADDRESS=smtp.heritage.africa \
  -e OPENPROJECT_EMAIL__SMTP__PORT=587 \
  -e OPENPROJECT_EMAIL__SMTP__AUTHENTICATION=:login \
  -e OPENPROJECT_EMAIL__SMTP__USER_NAME=support@mail.heritage.africa \
  -e OPENPROJECT_EMAIL__SMTP__PASSWORD=Accel@2025 \
  -v /var/lib/openproject/pgdata:/var/openproject/pgdata \
  -v /var/lib/openproject/assets:/var/openproject/assets \
  -v /var/lib/openproject/logs:/var/log/supervisor \
  -v /var/lib/openproject/static:/var/openproject/static \
  openproject/community:12

# Arrêt du container
ExecStop=/usr/bin/docker stop openproject
ExecStopPost=/usr/bin/docker rm openproject

# Redémarrage
ExecReload=/usr/bin/docker restart openproject

[Install]
WantedBy=multi-user.target
