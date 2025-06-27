package cl.redvecinal.backend.security.userdetails;

import cl.redvecinal.backend.common.exception.AuthenticationException;
import cl.redvecinal.backend.user.model.User;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * Service implementation of the UserDetailsService interface to load user-specific data.
 * This service is responsible for retrieving user details based on the phone number.
 */
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository userRepository;
    /**
     * Loads the user details by the provided phone number.
     *
     * @param phoneNumber the phone number identifying the user whose data is required
     * @return a UserDetails object containing the user's information
     * @throws UsernameNotFoundException if the user is not found
     */
    @Override
    public UserDetails loadUserByUsername(String phoneNumber) throws UsernameNotFoundException {
        User user = userRepository.findByPhoneNumber(phoneNumber)
                .orElseThrow(() -> new AuthenticationException("El telefono no fue encontrado"));
        return new CustomUserDetails(user);
    }
}
