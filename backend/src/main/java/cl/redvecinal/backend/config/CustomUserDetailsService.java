package cl.redvecinal.backend.config;

import cl.redvecinal.backend.user.repository.UserRepository;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    private UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String phone) throws UsernameNotFoundException {
        cl.redvecinal.backend.user.model.User user = userRepository.findByPhone(phone)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with phone: " + phone));

        System.out.println("Usuario encontrado: " + user.getPhone() + ", Password (hashed): " + user.getPassword());
        return new org.springframework.security.core.userdetails.User(
                user.getPhone(),
                user.getPassword(),
                new ArrayList<>()
        );
    }
}
