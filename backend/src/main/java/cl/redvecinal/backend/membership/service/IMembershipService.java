package cl.redvecinal.backend.membership.service;

import cl.redvecinal.backend.membership.dto.response.MembershipDto;
import cl.redvecinal.backend.membership.dto.response.MembershipRequestDto;
import cl.redvecinal.backend.membership.model.Membership;

import java.util.List;

public interface IMembershipService {
    Membership create (Membership membership);
    MembershipDto getMyMembership();
    List<MembershipRequestDto> getMyCommunityMemberships();
    void leaveCommunity();
    void rejectMembership(Long membershipId);
    void assignAdmin(Long membershipId);
    void unassignRoles(Long membershipId);
    void acceptMembership(Long membershipId);
}
