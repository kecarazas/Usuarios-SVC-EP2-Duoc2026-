# Usuarios — Resumen del microservicio

## Propósito

administra los datos y la lógica del dominio de Usuarios del caso caso10 (CargoClick).

## Contexto

- **Caso**: caso10 — CargoClick (Logística / courier)
- **Microservicio**: usuarios
- **Base path**: `/api/usuarios`

## Responsabilidad única (SRP)

El servicio atiende un único dominio de negocio y tiene una sola razón de cambio. Entrega su propia base de datos en memoria (H2) y expone su API REST de forma independiente, garantizando **bajo acoplamiento** y **alta cohesión** dentro de la arquitectura de microservicios del caso.

## Stack tecnológico

| Componente | Tecnología |
|---|---|
| Framework | Spring Boot 3.3 |
| Lenguaje | Java 21 |
| Build | Maven |
| Persistencia | Spring Data JPA + H2 (in-memory) |
| Validación | Bean Validation (`jakarta.validation`) |
| API/Docs | springdoc-openapi — Swagger UI + OpenAPI yaml + ReDoc |
| Calidad | JaCoCo (cobertura LINE 100%) + Cucumber (BDD REST) |
| Contenedores | Docker + Docker Compose |

## Entradas disponibles desde la web (`/`)

La página raíz presenta el servicio y enlaza Swagger UI, OpenAPI yaml, ReDoc y la consola H2.
