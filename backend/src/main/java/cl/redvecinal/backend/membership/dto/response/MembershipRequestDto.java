package cl.redvecinal.backend.membership.dto.response;

import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.user.dto.UserDto;
import lombok.Data;

@Data
public class MembershipRequestDto {
    private Long id;
    private MembershipStatus status = MembershipStatus.PENDING;
    private MembershipRole role = MembershipRole.MEMBER;
    private UserDto userDto;
}
