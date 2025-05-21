package cl.redvecinal.backend.auth.service;

import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import org.springframework.stereotype.Service;

@Service
public interface AuthService {
    String login (LoginRequest request);
    String register (RegisterRequest request);
}
