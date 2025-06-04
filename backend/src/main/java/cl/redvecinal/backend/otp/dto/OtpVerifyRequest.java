package cl.redvecinal.backend.otp.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OtpVerifyRequest {
    private String phoneNumber;
    private String code;
}
