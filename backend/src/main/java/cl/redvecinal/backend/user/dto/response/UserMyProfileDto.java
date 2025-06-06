package cl.redvecinal.backend.user.dto.response;

import lombok.Data;

@Data
public class UserMyProfileDto {
    private String username;
    private String phoneNumber;
    private String description;
    private String nameOfCommunity;
}
