podman run -d \
  -p 8080:80 \
  --name openproject \
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