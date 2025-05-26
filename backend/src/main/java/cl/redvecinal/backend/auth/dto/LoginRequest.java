package cl.redvecinal.backend.auth.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.Getter;
import lombok.Setter;

@Schema(description = "Request object for user login.")
@Getter
@Setter
public class LoginRequest {

    @Schema(description = "The phone number of the user. This field is required and cannot be blank.")
    @NotBlank(message = "Phone is required")
    private String phoneNumber;

    @Schema(description = "The password of the user. This field is required and cannot be blank.")
    @NotBlank(message = "Password is required")
    private String password;
}
