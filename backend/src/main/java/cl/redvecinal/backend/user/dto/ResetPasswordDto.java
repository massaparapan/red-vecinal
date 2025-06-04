package cl.redvecinal.backend.user.dto;

import lombok.Data;

@Data
public class ResetPasswordDto {
    private String phoneNumber;
    private String newPassword;
}
