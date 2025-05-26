package cl.redvecinal.backend.user.service;

import cl.redvecinal.backend.user.dto.UserDTO;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    @Override
    public UserDTO getUserById() {
        return null;
    }
    @Override
    public boolean isUserRegistered(String phoneNumber) {
        return userRepository.existsByPhone(phoneNumber);
    }
}
