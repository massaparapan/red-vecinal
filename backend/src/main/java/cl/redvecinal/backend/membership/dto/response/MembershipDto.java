package cl.redvecinal.backend.membership.dto.response;

import cl.redvecinal.backend.community.dto.CommunityDto;
import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import lombok.Data;

@Data
public class MembershipDto {
    private MembershipStatus status = MembershipStatus.PENDING;
    private MembershipRole role = MembershipRole.MEMBER;
}
