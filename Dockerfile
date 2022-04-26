FROM quay.io/keycloak/keycloak:latest as builder

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,scripts,admin2
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
# change these values to point to a running postgres instance
ENV KC_HTTP_ENABLED=true
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
