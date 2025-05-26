package cl.redvecinal.backend.auth.dto;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class RegisterRequest {
    private String username;
    private String phoneNumber;
    private String password;
}
