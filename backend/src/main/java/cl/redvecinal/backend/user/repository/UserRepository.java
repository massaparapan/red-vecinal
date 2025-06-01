package cl.redvecinal.backend.user.repository;

import cl.redvecinal.backend.user.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByPhoneNumber (String phone);
    Boolean existsByPhoneNumber(String phone);
}
