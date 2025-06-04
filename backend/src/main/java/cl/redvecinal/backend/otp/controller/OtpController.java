package cl.redvecinal.backend.otp.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
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
    @PostMapping("/send")
    public ResponseEntity<SuccesResponse> sendCode (@RequestParam String phoneNumber) {
        otpService.sendOTP(phoneNumber);
        return ResponseHelper.success("OTP enviado correctamente");
    }
    @PostMapping("/verify")
    public ResponseEntity<SuccesResponse> verifyCode (@RequestBody @Valid OtpVerifyRequest request) {
        Map<String, Object> response = new HashMap<>();
        response.put("valid", otpService.verifyOTP(request.getPhoneNumber(), request.getCode()));
        if (response.get("valid").equals(Boolean.TRUE)) {
            String token = jwtTokenProvider.generatePasswordResetToken(request.getPhoneNumber());
            response.put("token", token);
        }
        return ResponseHelper.success(response);
    }
}
