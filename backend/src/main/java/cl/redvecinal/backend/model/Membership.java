package cl.redvecinal.backend.model;

import cl.redvecinal.backend.community.model.Community;
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
    @OneToOne
    private User user;
    @ManyToOne
    private Community community;
}
