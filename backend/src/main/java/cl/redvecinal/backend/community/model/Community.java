package cl.redvecinal.backend.community.model;

import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.annoucement.model.Announcement;
import cl.redvecinal.backend.model.Event;
import cl.redvecinal.backend.membership.model.Membership;
import jakarta.persistence.*;
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
    @OneToMany(mappedBy = "community", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private Set<Membership> memberships = new HashSet<>();
    @OneToMany(mappedBy = "community", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Announcement> announcements;
    @OneToMany(mappedBy = "community", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Event> events;

    public int getMembersCount() {
        return (int) memberships.stream()
                .filter(m -> MembershipStatus.ACTIVE.equals(m.getStatus()))
                .count();
    }
}
