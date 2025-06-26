package cl.redvecinal.backend.event.model;

import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.util.Set;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Event {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String description;
    private LocalDate date;
    @ManyToOne
    private User createdBy;
    @ManyToOne
    private Community community;
    @OneToMany(mappedBy = "event", cascade = CascadeType.ALL)
    private Set<EventParticipation> participations;
}
