package cl.redvecinal.backend.user.dto.request;

import lombok.Data;

@Data
public class UpdateProfileDto {
    private String username;
    private String description;
}
