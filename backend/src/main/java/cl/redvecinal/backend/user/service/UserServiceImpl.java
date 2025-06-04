package cl.redvecinal.backend.user.service;

import cl.redvecinal.backend.user.exception.UserNotFoundException;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    @Override
    public boolean isUserRegistered(String phoneNumber) {
        return userRepository.existsByPhoneNumber(phoneNumber);
    }
    @Override
    public void resetPassword(String phoneNumber, String password) {
        User user = userRepository.findByPhoneNumber(phoneNumber)
                .orElseThrow(() -> new UserNotFoundException("Usuario no encontrado con el número de teléfono proporcionado: " + phoneNumber));
        user.setPassword(passwordEncoder.encode(password));
        userRepository.save(user);
    }
}
