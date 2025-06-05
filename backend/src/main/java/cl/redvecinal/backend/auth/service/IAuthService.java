package cl.redvecinal.backend.auth.service;

import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;

public interface IAuthService {
    String login (LoginRequest request);
    String register (RegisterRequest request);
}
