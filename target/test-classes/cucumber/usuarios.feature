# language: es
Característica: Servicio Usuarios (microservicio usuarios del caso caso10)
  Los escenarios validan el contrato REST del microservicio alineado a sus endpoints.

  Escenario: el listado del recurso responde 200
    Dado el servicio "Usuarios" está disponible
    Cuando consulto el listado de "usuarios"
    Entonces el listado responde con código 200

  Escenario: ciclo de vida completo del recurso
    Dado un nuevo "usuario" con nombre "hola-cucumber"
    Cuando consulto el "usuario" recién creado
    Entonces el recurso tiene nombre "hola-cucumber" y código 200
    Cuando actualizo el "usuario" con nombre "cucumber-actualizado"
    Entonces el recurso queda con nombre "cucumber-actualizado" y código 200
    Cuando elimino el "usuario"
    Entonces la eliminación responde con código 204
    Y al consultar el "usuario" eliminado responde 404
