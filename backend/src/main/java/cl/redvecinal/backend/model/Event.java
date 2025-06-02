package cl.redvecinal.backend.model;

import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.model.EventParticipation;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

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
