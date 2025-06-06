package cl.redvecinal.backend.config.services.impl;

import cl.redvecinal.backend.config.CustomUserDetails;
import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class AuthContextImpl implements IAuthContext {
    private final UserRepository userRepository;
    /**
     * Retrieves the currently authenticated user from the security context.
     * The method extracts the user details from the SecurityContextHolder,
     * fetches the user from the database using their ID, and returns the User object.
     * If the user is not found, a RuntimeException is thrown.
     *
     * @return the User object representing the currently authenticated user
     * @throws RuntimeException if the user is not found in the authentication context
     */
    public User getCurrentUser() {
        CustomUserDetails authentication = (CustomUserDetails) SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
        return userRepository.findById(authentication.user().getId())
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado en el contexto de autenticación"));
    }
}
