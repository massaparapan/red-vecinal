package cl.redvecinal.backend.user.service.impl;

import cl.redvecinal.backend.auth.service.AuthContext;
import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.user.dto.UserMapper;
import cl.redvecinal.backend.user.dto.request.UpdateProfileDto;
import cl.redvecinal.backend.user.dto.response.UserMyProfileDto;
import cl.redvecinal.backend.user.dto.response.UserProfileDto;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import cl.redvecinal.backend.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * Implementation of the UserService interface for managing user-related operations.
 * This service provides methods for user registration checks, password resets, profile retrieval, and profile updates.
 */
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    private final AuthContext authContext;
    private final UserMapper userMapper;

    /**
     * Checks if a user is registered based on their phone number.
     *
     * @param phoneNumber the phone number to check
     */
    @Override
    public boolean isUserRegistered(String phoneNumber) {
        return userRepository.existsByPhoneNumber(phoneNumber);
    }

    /**
     * Resets the password for a user identified by their phone number.
     * If the user is not found, a NotFoundException is thrown.
     *
     * @param phoneNumber the phone number of the user
     * @param password the new password to set
     */
    @Override
    public void resetPassword(String phoneNumber, String password) {
        User user = userRepository.findByPhoneNumber(phoneNumber)
                .orElseThrow(() -> new NotFoundException("Usuario no encontrado con el número de teléfono proporcionado: " + phoneNumber));
        user.setPassword(passwordEncoder.encode(password));
        userRepository.save(user);
    }

    /**
     * Retrieves the profile of the currently authenticated user.
     *
     * @return a UserMyProfileDto containing the profile information of the current user
     */
    @Override
    public UserMyProfileDto showMyProfile() {
        return userMapper.toUserMyProfileDto(authContext.getCurrentUser());
    }

    /**
     * Retrieves the profile of a user by their ID.
     * If the user is not found, a NotFoundException is thrown.
     *
     * @param id the ID of the user
     * @return a UserProfileDto containing the profile information of the user
     */
    @Override
    public UserProfileDto showProfileUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Usuario no encontrado con el ID proporcionado: " + id));
        return userMapper.toUserProfileDto(user);
    }

    /**
     * Updates the profile of the currently authenticated user.
     *
     * @param request an UpdateProfileDto containing the updated profile information
     */
    @Override
    public void updateMyProfile(UpdateProfileDto request) {
        User user = authContext.getCurrentUser();
        user.setUsername(request.getUsername());
        user.setDescription(request.getDescription());
        userRepository.save(user);
    }
}