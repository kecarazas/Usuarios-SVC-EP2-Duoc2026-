package cl.duoc.caso10.usuarios;

import org.junit.jupiter.api.Test;
import cl.duoc.caso10.usuarios.config.OpenApiConfig;

import static org.assertj.core.api.Assertions.assertThat;

class OpenApiConfigTest {

    @Test
    void beanOpenApiGenerado() {
        assertThat(new OpenApiConfig().customOpenAPI()).isNotNull();
    }
}
