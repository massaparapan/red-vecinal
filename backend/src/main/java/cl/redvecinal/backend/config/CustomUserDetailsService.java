package cl.redvecinal.backend.config;

import cl.redvecinal.backend.auth.exception.CredentialsNotFoundException;
import cl.redvecinal.backend.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository userRepository;
    @Override
    public UserDetails loadUserByUsername(String phone) throws UsernameNotFoundException {
        cl.redvecinal.backend.user.model.User user = userRepository.findByPhone(phone)
                .orElseThrow(() -> new CredentialsNotFoundException("Phone not found: " + phone));

        return new org.springframework.security.core.userdetails.User(
                user.getPhone(),
                user.getPassword(),
                new ArrayList<>()
        );
    }
}
