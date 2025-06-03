package cl.redvecinal.backend.user.service;

import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    @Override
    public boolean isUserRegistered(String phoneNumber) {
        return userRepository.existsByPhoneNumber(phoneNumber);
    }
}
