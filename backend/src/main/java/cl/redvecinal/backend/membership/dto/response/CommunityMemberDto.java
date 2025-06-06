package cl.redvecinal.backend.membership.dto.response;

import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import lombok.Data;

@Data
public class CommunityMemberDto {
    private Long id;
    private String username;
    private MembershipRole role;
}
