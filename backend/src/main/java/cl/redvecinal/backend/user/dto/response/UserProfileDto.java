package cl.redvecinal.backend.user.dto.response;

import lombok.Data;

@Data
public class UserProfileDto {
    private String username;
    private String description;
    private String nameOfCommunity;
}
