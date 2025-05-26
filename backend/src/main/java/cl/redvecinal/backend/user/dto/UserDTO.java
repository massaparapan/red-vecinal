package cl.redvecinal.backend.user.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
@Schema(description = "Data Transfer Object for User information.")
@Data
public class UserDTO {
    @Schema(description = "Unique identifier for the user.")
    private Long id;
    @Schema(description = "Username of the user.")
    private String username;
    @Schema(description = "Phone number of the user.")
    private String phone;
    @Schema(description = "Password of the user. This field should be stored securely.")
    private String password;
}
