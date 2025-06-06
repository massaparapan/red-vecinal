package cl.redvecinal.backend.otp.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.config.JwtTokenProvider;
import cl.redvecinal.backend.otp.service.OtpService;
import cl.redvecinal.backend.otp.dto.OtpVerifyRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RequestMapping("/api/otp")
@RestController
@RequiredArgsConstructor
public class OtpController {
    private final OtpService otpService;
    private final JwtTokenProvider jwtTokenProvider;

    /**
     * Sends an OTP (One-Time Password) to the specified phone number.
     * The OTP is sent using the OTP service, and a success response is returned.
     *
     * @param phoneNumber the phone number to which the OTP will be sent
     * @return a ResponseEntity containing a SuccessResponse indicating the OTP was sent successfully
     */
    @PostMapping("/send")
    public ResponseEntity<SuccessResponse> sendCode(@RequestParam String phoneNumber) {
        otpService.sendOTP(phoneNumber);
        return ResponseHelper.success("OTP enviado correctamente");
    }

    /**
     * Verifies the OTP (One-Time Password) for the specified phone number.
     * If the OTP is valid, a password reset token is generated and included in the response.
     * The response contains a map with a boolean value indicating the validity of the OTP
     * and, if valid, the generated token.
     *
     * @param request the request body containing the phone number and OTP to verify
     * @return a ResponseEntity containing a SuccessResponse with the verification result and token (if valid)
     */
    @PostMapping("/verify")
    public ResponseEntity<SuccessResponse> verifyCode(@RequestBody @Valid OtpVerifyRequest request) {
        Map<String, Object> response = new HashMap<>();
        response.put("valid", otpService.verifyOTP(request.getPhoneNumber(), request.getCode()));
        if (response.get("valid").equals(Boolean.TRUE)) {
            String token = jwtTokenProvider.generatePasswordResetToken(request.getPhoneNumber());
            response.put("token", token);
        }
        return ResponseHelper.success(response);
    }
}
