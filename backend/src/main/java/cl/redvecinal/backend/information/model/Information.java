package cl.redvecinal.backend.information.model;

import cl.redvecinal.backend.community.model.Community;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Information {
    @Id
    private Long id;
    private String title;
    private String content;
    @ManyToOne
    private Community community;
}
