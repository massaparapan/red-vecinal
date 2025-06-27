package cl.redvecinal.backend.annoucement.model;

import cl.redvecinal.backend.annoucement.model.enums.AnnouncementType;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Announcement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String content;
    @CreationTimestamp
    private LocalDateTime createdAt;
    private AnnouncementType type;
    @ManyToOne
    private User createdBy;
    @ManyToOne
    private Community community;
}
