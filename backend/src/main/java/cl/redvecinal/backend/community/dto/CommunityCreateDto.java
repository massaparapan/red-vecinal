package cl.redvecinal.backend.community.dto;

import java.time.LocalDate;
import lombok.Data;
@Data
public class CommunityCreateDto {

    private String name;
    private String description;
    private String lat;
    private String lon;
}
