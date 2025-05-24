package cl.redvecinal.backend.auth.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.service.AuthService;
import cl.redvecinal.backend.common.util.ResponseHelper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/auth")
@RestController
@RequiredArgsConstructor
public class AuthController {
    private final AuthService authService;
    @PostMapping("/login")
    public ResponseEntity<SuccesResponse> login(@Valid @RequestBody LoginRequest request) {
        String token = authService.login(request);
        return ResponseHelper.success("token: " + token);
    }
    @PostMapping("/register")
    public ResponseEntity<SuccesResponse> register(@Valid @RequestBody RegisterRequest request) {
        String token = authService.register(request);
        return ResponseHelper.success("token: " + token);
    }
}
