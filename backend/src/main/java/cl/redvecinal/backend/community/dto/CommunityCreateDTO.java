package cl.redvecinal.backend.community.dto;

import java.time.LocalDate;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Schema(description = "Data Transfer Object for creating a community.")
@Data
public class CommunityCreateDTO {

    @Schema(description = "Unique identifier for the community. This field is required.")
    private String name;
    @Schema(description = "Description of the community. This field is optional.")
    private String description;
    @Schema(description = "Latitude of the community's location. This field is required.")
    private String lat;
    @Schema(description = "Longitude of the community's location. This field is required.")
    private String lon;
    @Schema(description = "Creation date of the community. Defaults to the current date if not provided.")
    private String creationDate = LocalDate.now().toString();
    @Schema(description = "Number of members in the community. Defaults to 1 if not provided.")
    private Integer membersCount = 1;
}
