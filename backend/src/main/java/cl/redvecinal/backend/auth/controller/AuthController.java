package cl.redvecinal.backend.auth.controller;

import cl.redvecinal.backend.auth.Response;
import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.service.AuthService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/auth")
@RestController
public class AuthController {
    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<Response> login(@Valid @RequestBody LoginRequest request) {
        String token = authService.login(request);
        boolean succes = token.isEmpty();
        Response response = Response.builder()
                .success(succes)
                .data("token: " + token)
                .error(null)
                .build();

        return succes ? ResponseEntity.ok(response) : ResponseEntity.notFound().build();
    }

    @PostMapping("/register")
    public ResponseEntity<String> register(@Valid @RequestBody RegisterRequest request) {
        String response = authService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

}
