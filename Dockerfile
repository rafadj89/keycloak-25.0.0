FROM quay.io/keycloak/keycloak:25.0.0

# Ejecutar el build de Keycloak (mejor rendimiento en inicio)
RUN /opt/keycloak/bin/kc.sh build

# Variables de entorno para admin
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Configuración de la base de datos Postgres (Render → External Database)
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://dpg-d46mm1je5dus73df82i0-a.virginia-postgres.render.com/keycloak_kf7c
ENV KC_DB_USERNAME=keycloak_kf7c_user
ENV KC_DB_PASSWORD=sWUZ2MBj4seL1b4r6YanU1WNoMi1n4N9

# Render asigna puerto dinámico → permitirlo
ENV KC_HTTP_ENABLED=true
EXPOSE 8080

# Evitar restricciones de hostname en entorno cloud
ENV KC_HOSTNAME_STRICT=false
ENV KC_PROXY_HEADERS=xforwarded

# Iniciar en modo desarrollo (rápido ideal para dev team remoto)
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", \
    "--http-port=${PORT}", \
    "--hostname-strict=false", \
    "--proxy-headers=xforwarded", \
    "--import-realm" \
]
