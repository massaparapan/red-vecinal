package cl.redvecinal.backend.membership.model;

import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Membership {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Enumerated(EnumType.STRING)
    private MembershipStatus status = MembershipStatus.PENDING;
    @Enumerated(EnumType.STRING)
    private MembershipRole role = MembershipRole.MEMBER;
    @OneToOne(cascade = CascadeType.MERGE)
    private User user;
    @ManyToOne(cascade = CascadeType.MERGE)
    private Community community;
}
