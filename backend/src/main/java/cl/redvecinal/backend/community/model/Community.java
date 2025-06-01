package cl.redvecinal.backend.community.model;

import cl.redvecinal.backend.announcement.model.Announcement;
import cl.redvecinal.backend.event.model.Event;
import cl.redvecinal.backend.community.membership.model.Membership;
import cl.redvecinal.backend.community.membership.model.MembershipRole;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.util.Set;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Community {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    @CreationTimestamp
    private LocalDate creationDate;
    private String lat;
    private String lon;
    @OneToMany(mappedBy = "community")
    private Set<Membership> memberships;
    @OneToMany(mappedBy = "community")
    private Set<Announcement> announcements;
    @OneToMany(mappedBy = "community")
    private Set<Event> events;
    @OneToOne
    private User createdBy;
    public int getMemberCount() {
        return (int) memberships.stream()
                .filter(m -> m.getRole() == MembershipRole.MEMBER || m.getRole() == MembershipRole.ADMIN)
                .count();
    }
}
