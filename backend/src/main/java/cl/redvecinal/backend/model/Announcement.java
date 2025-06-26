package cl.redvecinal.backend.model;

import cl.redvecinal.backend.annoucement.model.AnnouncementType;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Announcement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title;
    private String content;
    private AnnouncementType type;
    @ManyToOne
    private User createdBy;
    @ManyToOne
    private Community community;
}
