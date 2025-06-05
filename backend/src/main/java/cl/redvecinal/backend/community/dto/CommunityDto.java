package cl.redvecinal.backend.community.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
@Data
@Setter
@Getter
public class CommunityDto {
    private Long id;
    private String name;
    private String description;
    private LocalDate creationDate;
    private String lat;
    private String lon;
    private int membersCount = 1;
}
