FROM quay.io/keycloak/keycloak:17.0.0 as builder

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,scripts,admin2
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:17.0.0
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin
# change these values to point to a running postgres instance
ENV KC_HTTP_ENABLED=true
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
