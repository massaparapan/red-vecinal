package cl.redvecinal.backend.user.dto;

import lombok.Data;
@Data
public class UserDTO {
    Long id;
    String username;
    String phone;
    String password;
}
