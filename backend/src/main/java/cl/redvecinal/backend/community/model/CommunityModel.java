package cl.redvecinal.backend.community.model;

import jakarta.annotation.Generated;
import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Entity
@Data
@Table(name = "community")
public class CommunityModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "name")
    private String name;
    @Column(name = "description")
    private String description;
    @Column(name = "creation_date")
    private String creationDate;
    @Column(name = "members_count")
    private Integer membersCount;
    @Column(name = "lat")
    private String lat;
    @Column(name = "lon")
    private String lon;

}
