package cl.redvecinal.backend.community.model;

import cl.redvecinal.backend.model.Announcement;
import cl.redvecinal.backend.model.Event;
import cl.redvecinal.backend.model.Membership;
import cl.redvecinal.backend.model.MembershipRole;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import jakarta.validation.constraints.Null;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import java.util.HashSet;
import java.util.Set;
import java.time.LocalDate;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Community {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NonNull
    private String name;
    @NonNull
    private String description;
    @CreationTimestamp
    private LocalDate creationDate;
    @NonNull
    private String lat;
    @NonNull
    private String lon;
    @OneToMany(mappedBy = "community")
    @Builder.Default
    private Set<Membership> memberships = new HashSet<>();
    @OneToMany(mappedBy = "community")
    @Null
    private Set<Announcement> announcements;
    @OneToMany(mappedBy = "community")
    @Null
    private Set<Event> events;
    @OneToOne
    @NonNull
    private User user;
    public int getMemberCount() {
        return (int) memberships.stream()
                .filter(m -> m.getRole() == MembershipRole.MEMBER || m.getRole() == MembershipRole.ADMIN)
                .count();
    }
}
