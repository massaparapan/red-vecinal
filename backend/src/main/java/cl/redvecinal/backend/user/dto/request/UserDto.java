package cl.redvecinal.backend.user.dto.request;

import lombok.Data;

@Data
public class UserDto {
    private Long id;
    private String username;
    private String phoneNumber;
}
