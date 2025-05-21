package cl.redvecinal.backend.config;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Implementa cómo buscar tu usuario, por ejemplo en BD
        // Aquí un ejemplo básico con usuario hardcodeado:
        if ("user".equals(username)) {
            return User.withUsername(username)
                    .password("{noop}password") // {noop} para no encriptar (solo para pruebas)
                    .roles("USER")
                    .build();
        } else {
            throw new UsernameNotFoundException("Usuario no encontrado");
        }
    }
}
