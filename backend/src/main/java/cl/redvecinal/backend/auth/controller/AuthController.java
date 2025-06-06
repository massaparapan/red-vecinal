package cl.redvecinal.backend.auth.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.service.IAuthService;
import cl.redvecinal.backend.common.util.ResponseHelper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RequestMapping("/api/auth")
@RestController
@RequiredArgsConstructor
public class AuthController {
    private final IAuthService authService;
    /**
     * Authenticates a user based on the provided login request.
     * Generates a token upon successful authentication and returns it in the response.
     *
     * @param request the login request containing the user's credentials
     * @return a ResponseEntity containing a SuccessResponse with the generated token
     */
    @PostMapping("/login")
    public ResponseEntity<SuccessResponse> login(@Valid @RequestBody LoginRequest request) {
        String token = authService.login(request);
        return ResponseHelper.success(Map.of("token", token));
    }

    /**
     * Registers a new user based on the provided registration request.
     * Generates a token upon successful registration and returns it in the response.
     *
     * @param request the registration request containing the user's details
     * @return a ResponseEntity containing a SuccessResponse with the generated token
     */
    @PostMapping("/register")
    public ResponseEntity<SuccessResponse> register(@Valid @RequestBody RegisterRequest request) {
        String token = authService.register(request);
        return ResponseHelper.success(Map.of("token", token));
    }
}