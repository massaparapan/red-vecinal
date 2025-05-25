package cl.redvecinal.backend.auth.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class LoginRequest {
    @NotBlank(message = "Phone is required")
    private String phoneNumber;

    @NotBlank(message = "Password is required")
    private String password;
}
