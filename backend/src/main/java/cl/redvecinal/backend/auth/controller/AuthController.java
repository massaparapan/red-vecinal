package cl.redvecinal.backend.auth.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.service.AuthService;
import cl.redvecinal.backend.common.util.ResponseHelper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Tag(name = "Authentication", description = "Endpoints for user authentication including login and registration.")
@RequestMapping("/api/auth")
@RestController
@RequiredArgsConstructor
public class AuthController {
        @Schema(description = "Service for handling authentication logic.")
        private final AuthService authService;

        @Operation(summary = "User login endpoint", description = "Allows users to log in using their phone number and password.")
        @PostMapping("/login")
        public ResponseEntity<SuccesResponse> login(@Valid @RequestBody LoginRequest request) {
            String token = authService.login(request);
            return ResponseHelper.success("token: " + token);
        }
        @Operation(summary = "User registration endpoint", description = "Allows new users to register by providing their phone number and password.")
        @PostMapping("/register")
        public ResponseEntity<SuccesResponse> register(@Valid @RequestBody RegisterRequest request) {
            String token = authService.register(request);
            return ResponseHelper.success("token: " + token);
        }
    }