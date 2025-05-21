package cl.redvecinal.backend.auth.dto;

import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import lombok.Getter;
import org.hibernate.annotations.NaturalId;

@Getter
public class UserDTO {

    Long id;
    String username;
    String phone;
    String password;

    public Long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPhone() {
        return phone;
    }

    public String getPassword() {
        return password;
    }
}
