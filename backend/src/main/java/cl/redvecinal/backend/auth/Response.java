package cl.redvecinal.backend.auth.dto;

import lombok.*;

@Getter
@Setter
public class AuthResponse {
    @NonNull
    private String message;
    @NonNull
    private String token;

    public AuthResponse(@NonNull String message, @NonNull String token) {
        this.message = message;
        this.token = token;
    }
}
