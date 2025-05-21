package cl.redvecinal.backend.auth.service;

import cl.redvecinal.backend.auth.dto.LoginRequest;
import cl.redvecinal.backend.auth.dto.RegisterRequest;
import cl.redvecinal.backend.auth.exception.RegisterException;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
@Service
public class AuthServiceImpl implements AuthService {
    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final AuthenticationManager authenticationManager;

    public AuthServiceImpl(UserRepository userRepository, JwtTokenProvider jwtTokenProvider, AuthenticationManager authenticationManager) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
        this.authenticationManager = authenticationManager;
    }

    private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(12);
    @Override
    public String login(LoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getPhone(),
                        request.getPassword()
                )
        );

        if (!authentication.isAuthenticated()) {
            return "";
        }

        return jwtTokenProvider.generateToken(request.getPhone());
    }

    @Override
    public String register(RegisterRequest request) {
        boolean userExists = userRepository.existsByPhone(request.getPhone());

        if (userExists) {
            throw new RegisterException("User already exists");
        }

        User user = new User(request.getUsername(), request.getPhone(), encoder.encode(request.getPassword()));
        userRepository.save(user);

        return jwtTokenProvider.generateToken(user.getPhone());
    }
}
