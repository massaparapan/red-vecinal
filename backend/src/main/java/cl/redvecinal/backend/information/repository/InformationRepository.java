package cl.redvecinal.backend.information.repository;

import cl.redvecinal.backend.information.model.Information;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InformationRepository extends JpaRepository<Information, Long> {
}
