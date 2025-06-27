package cl.redvecinal.backend.security.userdetails;

import cl.redvecinal.backend.user.model.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
/**
 * Custom implementation of the UserDetails interface to represent the authenticated user.
 * This class is implemented as a record, encapsulating a User object.
 */
public record CustomUserDetails(User user) implements UserDetails {
    /**
     * Retrieves the authorities granted to the user.
     * Currently, this method returns null as no authorities are defined.
     *
     * @return a collection of granted authorities, or null if none are defined
     */
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return null;
    }
    /**
     * Retrieves the password of the user.
     *
     * @return the user's password
     */
    @Override
    public String getPassword() {
        return user.getPassword();
    }
    /**
     * Retrieves the username of the user.
     *
     * @return the user's username
     */
    @Override
    public String getUsername() {
        return user.getUsername();
    }
}