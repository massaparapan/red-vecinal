package cl.redvecinal.backend.user.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;
import org.hibernate.annotations.NaturalId;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Long id;

    @NonNull
    String username;

    @NonNull
    String phone;
    @NonNull
    String password;

    public User(@NonNull String username, @NonNull String phone, @NonNull String password) {
        this.username = username;
        this.phone = phone;
        this.password = password;
    }

    public User() {
        // constructor vacío requerido por JPA/Hibernate
    }
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
