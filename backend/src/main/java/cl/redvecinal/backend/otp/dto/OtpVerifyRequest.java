package cl.redvecinal.backend.otp.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.NoArgsConstructor;

@Schema(description = "Request object for verifying an OTP (One Time Password).")
@Data
@NoArgsConstructor
public class OtpVerifyRequest {
    @Schema(description = "The phone number associated with the OTP. This field is required.")
    private String phoneNumber;
    @Schema(description = "The OTP code to be verified. This field is required.")
    private String code;
}
