package cl.redvecinal.backend.auth.service.impl;

import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.security.userdetails.CustomUserDetails;
import cl.redvecinal.backend.auth.service.AuthContext;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

/**
 * Implementation of the AuthContext interface for managing authentication-related operations.
 * This component provides methods to retrieve the currently authenticated user.
 */
@Component
@RequiredArgsConstructor
public class AuthContextImpl implements AuthContext {
    private final UserRepository userRepository;

    /**
     * The method extracts the user details from the SecurityContextHolder,
     * fetches the user from the database using their ID, and returns the User object.
     *
     * @return the User object representing the currently authenticated user
     */
    public User getCurrentUser() {
        CustomUserDetails authentication = (CustomUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        return userRepository.findById(authentication.user().getId())
                .orElseThrow(() -> new NotFoundException("Usuario no encontrado en el contexto de autenticación"));
    }
}
