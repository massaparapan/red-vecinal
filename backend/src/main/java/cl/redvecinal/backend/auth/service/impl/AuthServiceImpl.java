package cl.redvecinal.backend.auth.service.impl;

import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.exception.IncorrectPasswordException;
import cl.redvecinal.backend.auth.exception.PhoneAlreadyExistsException;
import cl.redvecinal.backend.auth.service.IAuthService;
import cl.redvecinal.backend.config.CustomUserDetails;
import cl.redvecinal.backend.config.JwtTokenProvider;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements IAuthService {
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final AuthenticationManager authenticationManager;
    private final PasswordEncoder encoder;
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
            throw new IncorrectPasswordException("La contraseña es incorrecta");
        }
    }

    @Override
    public String register(RegisterRequest request) {
        boolean phoneExists = userRepository.existsByPhoneNumber(request.getPhoneNumber());
        if (phoneExists) {
            throw new PhoneAlreadyExistsException("El telefono " + request.getPhoneNumber() + " ya esta en uso");
        }
        User user = new User(request.getUsername(), request.getPhoneNumber(), encoder.encode(request.getPassword()));
        userRepository.save(user);
        return jwtTokenProvider.generateToken(user);
    }
}
