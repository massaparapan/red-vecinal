package cl.redvecinal.backend.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Schema(description = "Request object for user registration")
@Getter
@Setter
public class RegisterRequest {

        @Schema(description = "User's username")
        @NotBlank(message = "Username is required")
        private String username;

        @Schema(description = "User's phoneNumber")
        @NotBlank(message = "PhoneNumber is required")
        private String phoneNumber;

        @Schema(description = "User's password")
        @NotBlank(message = "Password is required")
        private String password;
}