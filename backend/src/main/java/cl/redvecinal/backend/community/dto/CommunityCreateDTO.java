package cl.redvecinal.backend.community.dto;

import java.time.LocalDate;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class CommunityCreateDTO {

    private String name;
    private String description;
    private String lat;
    private String lon;
    private String creationDate = LocalDate.now().toString();
    private Integer membersCount = 1;
}
