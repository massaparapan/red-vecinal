package cl.redvecinal.backend.otp.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.otp.service.OtpService;
import cl.redvecinal.backend.otp.dto.OtpVerifyRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RequestMapping("/api/otp")
@RestController
@RequiredArgsConstructor
public class OtpController {
    private final OtpService otpService;
    @PostMapping("/send")
    public ResponseEntity<SuccesResponse> sendCode (@RequestParam String phoneNumber) {
        otpService.sendOTP(phoneNumber);
        return ResponseHelper.success("OTP enviado correctamente");
    }
    @PostMapping("/verify")
    public ResponseEntity<SuccesResponse> verifyCode (@RequestBody OtpVerifyRequest request) {
        return ResponseHelper.success(Map.of(
                "valid", otpService.verifyOTP(request.getPhoneNumber(), request.getCode()
                )
        ));
    }
}
