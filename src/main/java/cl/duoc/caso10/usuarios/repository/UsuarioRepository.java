package cl.duoc.caso10.usuarios.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import cl.duoc.caso10.usuarios.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
}
