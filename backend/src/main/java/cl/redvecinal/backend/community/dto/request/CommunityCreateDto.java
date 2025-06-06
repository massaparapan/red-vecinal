package cl.redvecinal.backend.community.dto.request;

import lombok.Data;
@Data
public class CommunityCreateDto {
    private String name;
    private String description;
    private String lat;
    private String lon;
}
