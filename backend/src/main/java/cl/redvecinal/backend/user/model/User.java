package cl.redvecinal.backend.user.model;

import cl.redvecinal.backend.membership.model.Membership;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Getter
@Setter
@AllArgsConstructor
@RequiredArgsConstructor
@NoArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NonNull
    private String username;
    @NonNull
    private String phoneNumber;
    @NonNull
    private String password;
    private String description = "";
    private String imageProfileUrl;
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private Membership membership;

    public String getNameOfCommunity() {
        if (membership == null) {
            return "No has solicitado unirte a una comunidad";
        }
        return membership.getStatus() == MembershipStatus.ACTIVE
                ? membership.getCommunity().getName()
                : "Aun no aceptado tu solicitud a la comunidad";
    }
}
