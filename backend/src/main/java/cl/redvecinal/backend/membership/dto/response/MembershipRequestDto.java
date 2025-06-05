package cl.redvecinal.backend.membership.dto.response;

import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.user.dto.request.UserDto;
import lombok.Data;

@Data
public class MembershipRequestDto {
    private Long id;
    private MembershipStatus status;
    private MembershipRole role;
    private UserDto userDto;
}
