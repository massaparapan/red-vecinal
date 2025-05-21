package cl.redvecinal.backend.respository;

import cl.redvecinal.backend.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByPhone (String phone);
    Boolean existsByPhone(String phone);
}
