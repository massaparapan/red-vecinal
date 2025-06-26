package cl.redvecinal.backend.user.service.impl;

import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.user.dto.UserMapper;
import cl.redvecinal.backend.user.dto.request.UpdateProfileDto;
import cl.redvecinal.backend.user.dto.response.UserMyProfileDto;
import cl.redvecinal.backend.user.dto.response.UserProfileDto;
import cl.redvecinal.backend.user.exception.UserNotFoundException;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import cl.redvecinal.backend.user.service.IUserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements IUserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private final IAuthContext authContext;
    private final UserMapper userMapper;
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

    @Override
    public UserMyProfileDto showMyProfile() {
        return userMapper.toUserMyProfileDto(authContext.getCurrentUser());
    }

    @Override
    public UserProfileDto showProfileUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("Usuario no encontrado con el ID proporcionado: " + id));
        return userMapper.toUserProfileDto(user);
    }

    @Override
    public void updateMyProfile(UpdateProfileDto request) {
        User user = authContext.getCurrentUser();
        user.setUsername(request.getUsername());
        user.setDescription(request.getDescription());
        userRepository.save(user);
    }
}
