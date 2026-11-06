# syntax=docker/dockerfile:1

# ---- Etapa 1: compilación ----
FROM maven:3.9-eclipse-temurin-26 AS build
WORKDIR /app
# Primero solo el pom: la capa de dependencias se reutiliza mientras el pom no cambie.
COPY pom.xml ./
RUN --mount=type=cache,target=/root/.m2 mvn -B -q dependency:go-offline
COPY src ./src
# Los tests se ejecutan en el job "build-test" del pipeline; aquí solo se empaqueta.
RUN --mount=type=cache,target=/root/.m2 mvn -B -q package -DskipTests

# ---- Etapa 2: ejecución ----
FROM eclipse-temurin:21-jre-alpine

# Trazabilidad (IE4): el pipeline inyecta el SHA del commit y la versión.
ARG GIT_SHA=local
ARG APP_VERSION=local
LABEL org.opencontainers.image.title="usuarios-svc" \
      org.opencontainers.image.description="Microservicio Usuarios - caso10 CargoClick" \
      org.opencontainers.image.revision="${GIT_SHA}" \
      org.opencontainers.image.version="${APP_VERSION}"
ENV GIT_SHA=${GIT_SHA} \
    APP_VERSION=${APP_VERSION} \
    JAVA_OPTS="-XX:MaxRAMPercentage=75.0 -XX:+UseContainerSupport -XX:+ExitOnOutOfMemoryError"

WORKDIR /app

# Usuario sin privilegios (no root).
RUN addgroup -S app && adduser -S app -G app

COPY --from=build --chown=app:app /app/target/*.jar app.jar

USER app
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=40s --retries=3 \
  CMD wget -qO- http://localhost:8080/actuator/health || exit 1

# "exec" deja a Java como PID 1 para que reciba SIGTERM y se apague limpio.
ENTRYPOINT ["sh", "-c", "exec java $JAVA_OPTS -jar app.jar"]
