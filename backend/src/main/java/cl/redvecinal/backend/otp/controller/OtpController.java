package cl.redvecinal.backend.otp.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.otp.service.OtpService;
import cl.redvecinal.backend.otp.dto.OtpVerifyRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Tag(name = "OTP Management", description = "Endpoints for managing One-Time Password (OTP) operations, such as sending and verifying OTP codes.")
@RequestMapping("/api/otp")
@RestController
@RequiredArgsConstructor
public class OtpController {
    private final OtpService otpService;
    @Operation(summary = "Send OTP code", description = "Sends a One-Time Password (OTP) to the specified phone number for verification purposes.")
    @PostMapping("/send")
    public ResponseEntity<SuccesResponse> sendCode (@RequestParam String phoneNumber) {
        System.out.println("Enviando OTP a: " + phoneNumber);
        otpService.sendOTP(phoneNumber);
        return ResponseHelper.success("OTP enviado correctamente");
    }
    @Operation(summary = "Verify OTP code", description = "Verifies the One-Time Password (OTP) provided by the user against the sent OTP for the specified phone number.")
    @PostMapping("/verify")
    public ResponseEntity<SuccesResponse> verifyCode (@RequestBody OtpVerifyRequest request) {
        return ResponseHelper.success(Map.of(
                "valid", otpService.verifyOTP(request.getPhoneNumber(), request.getCode()
                )
        ));
    }
}
