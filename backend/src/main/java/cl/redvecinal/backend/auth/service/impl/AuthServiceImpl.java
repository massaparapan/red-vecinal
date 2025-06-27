package cl.redvecinal.backend.auth.service.impl;

import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.service.AuthService;
import cl.redvecinal.backend.common.exception.AuthenticationException;
import cl.redvecinal.backend.common.exception.ConflictException;
import cl.redvecinal.backend.security.userdetails.CustomUserDetails;
import cl.redvecinal.backend.security.jwt.JwtTokenProvider;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * Implementation of the AuthService interface for managing authentication-related operations.
 * This service provides methods for user login and registration.
 */
@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder encoder;

    /**
     * Authenticates a user based on the provided login request.
     * The method attempts to authenticate the user using their phone number and password.
     * If authentication is successful, a JWT token is generated and returned.
     *
     * @param request the LoginRequest containing the user's phone number and password
     * @return a JWT token as a String if authentication is successful
     */
    @Override
    public String login(LoginRequest request) {
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            request.getPhoneNumber(),
                            request.getPassword()
                    )
            );
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            return jwtTokenProvider.generateToken(userDetails.user());
        } catch (BadCredentialsException e) {
            throw new AuthenticationException("La contraseña es incorrecta");
        }
    }

    /**
     * Registers a new user based on the provided registration request.
     *
     * @param request the RegisterRequest containing the user's username, phone number, and password
     * @return a JWT token as a String for the newly registered user
     */
    @Override
    public String register(RegisterRequest request) {
        boolean phoneExists = userRepository.existsByPhoneNumber(request.getPhoneNumber());
        if (phoneExists) {
            throw new ConflictException("El telefono " + request.getPhoneNumber() + " ya esta en uso");
        }
        User user = new User(request.getUsername(), request.getPhoneNumber(), encoder.encode(request.getPassword()));
        userRepository.save(user);
        return jwtTokenProvider.generateToken(user);
    }
}
