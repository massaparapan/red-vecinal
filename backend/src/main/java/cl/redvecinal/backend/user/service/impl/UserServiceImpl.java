package cl.redvecinal.backend.user.service.impl;

import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.user.dto.UserMapper;
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
    /**
     * Checks if a user is registered based on their phone number.
     *
     * @param phoneNumber the phone number to check
     * @return true if the user is registered, false otherwise
     */
    @Override
    public boolean isUserRegistered(String phoneNumber) {
        return userRepository.existsByPhoneNumber(phoneNumber);
    }

    /**
     * Resets the password for a user identified by their phone number.
     * Encodes the new password and updates the user's record in the repository.
     * Throws an exception if the user is not found.
     *
     * @param phoneNumber the phone number of the user
     * @param password the new password to set
     * @throws UserNotFoundException if no user is found with the provided phone number
     */
    @Override
    public void resetPassword(String phoneNumber, String password) {
        User user = userRepository.findByPhoneNumber(phoneNumber)
                .orElseThrow(() -> new UserNotFoundException("Usuario no encontrado con el número de teléfono proporcionado: " + phoneNumber));
        user.setPassword(passwordEncoder.encode(password));
        userRepository.save(user);
    }

    /**
     * Retrieves the profile of the currently authenticated user.
     *
     * @return a UserMyProfileDto containing the profile details of the authenticated user
     */
    @Override
    public UserMyProfileDto showMyProfile() {
        return userMapper.toUserMyProfileDto(authContext.getCurrentUser());
    }

    /**
     * Retrieves the profile of a user by their ID.
     * Throws an exception if the user is not found.
     *
     * @param id the ID of the user to retrieve
     * @return a UserProfileDto containing the profile details of the user
     * @throws UserNotFoundException if no user is found with the provided ID
     */
    @Override
    public UserProfileDto showProfileUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("Usuario no encontrado con el ID proporcionado: " + id));
        return userMapper.toUserProfileDto(user);
    }
}
