package cl.redvecinal.backend.community.repository;

import cl.redvecinal.backend.community.model.CommunityModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommunityRepository extends JpaRepository<CommunityModel, Long> {

}