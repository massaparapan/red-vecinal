package cl.redvecinal.backend.membership.repository;

import cl.redvecinal.backend.membership.model.Membership;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MembershipRepository extends JpaRepository<Membership, Long> {
    List<Membership> findByCommunityId(Long communityId);
}
