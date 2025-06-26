package cl.redvecinal.backend.event.repository;

import cl.redvecinal.backend.event.model.EventParticipation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EventParticipationRepository extends JpaRepository<EventParticipation, Long> {
    List<EventParticipation> findByUserId(Long userId);
}