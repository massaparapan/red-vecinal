package cl.redvecinal.backend.membership.service.impl;

import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.membership.dto.response.MembershipDto;
import cl.redvecinal.backend.membership.dto.MembershipMapper;
import cl.redvecinal.backend.membership.dto.response.MembershipRequestDto;
import cl.redvecinal.backend.membership.model.Membership;
import cl.redvecinal.backend.membership.repository.MembershipRepository;
import cl.redvecinal.backend.membership.service.IMembershipService;
import cl.redvecinal.backend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MembershipServiceImpl implements IMembershipService {

    private final MembershipRepository membershipRepository;

    private final MembershipMapper membershipMapper;
    private final IAuthContext authService;
    @Override
    public Membership create(Membership membership){
        return membershipRepository.save(membership);
    }
    @Override
    public MembershipDto getMyMembership() {
        User currentUser = authService.getCurrentUser();
        return membershipMapper.toDto(currentUser.getMembership());
    }

    @Override
    public List<MembershipRequestDto> getMyCommunityMemberships() {
        User currentUser = authService.getCurrentUser();
        Long communityId = currentUser.getMembership().getCommunity().getId();
        List<Membership> memberships = membershipRepository.findByCommunityId(communityId);

        return memberships.stream()
                .map(membershipMapper::toRequestDto)
                .toList();
    }
}
