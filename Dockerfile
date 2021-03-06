FROM quay.io/keycloak/keycloak:latest as builder1

ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,scripts
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder1 /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
# change these values to point to a running postgres instance
ENV KC_HTTP_ENABLED=true
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
