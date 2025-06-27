package cl.redvecinal.backend.membership.service.impl;

import cl.redvecinal.backend.auth.service.AuthContext;
import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.membership.dto.response.CommunityMemberDto;
import cl.redvecinal.backend.membership.dto.response.MembershipDto;
import cl.redvecinal.backend.membership.dto.MembershipMapper;
import cl.redvecinal.backend.membership.dto.response.MembershipRequestDto;
import cl.redvecinal.backend.membership.model.Membership;
import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.membership.repository.MembershipRepository;
import cl.redvecinal.backend.membership.service.IMembershipService;
import cl.redvecinal.backend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MembershipServiceImpl implements IMembershipService {

    private final MembershipRepository membershipRepository;

    private final MembershipMapper membershipMapper;
    private final AuthContext authService;

    @Override
    public Membership create(Membership membership){
        return membershipRepository.save(membership);
    }
    @Override
    public MembershipDto getMyMembership() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new NotFoundException("No tienes una membresía vinculada.");
        }
        return membershipMapper.toDto(currentUser.getMembership());
    }

    @Override
    public List<MembershipRequestDto> getMyCommunityMemberships() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new NotFoundException("No tienes una membresía vinculada.");
        }
        Long communityId = currentUser.getMembership().getCommunity().getId();
        List<Membership> memberships = membershipRepository.findByCommunityId(communityId);
        return memberships.stream()
                .map(membershipMapper::toRequestDto)
                .toList();
    }

    @Override
    public void leaveCommunity() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new NotFoundException("No tienes una membresía vinculada.");
        }
        Membership membership = currentUser.getMembership();
        currentUser.setMembership(null);
        membershipRepository.delete(membership);
    }

    @Override
    public void rejectMembership(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        User user = membership.getUser();
        user.setMembership(null);
        membershipRepository.delete(membership);
    }

    @Override
    public void assignAdmin(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        membership.setRole(MembershipRole.ADMIN);
        membershipRepository.save(membership);
    }

    @Override
    public void unassignRoles(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        membership.setRole(MembershipRole.MEMBER);
        membershipRepository.save(membership);
    }

    @Override
    public void acceptMembership(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        membership.setRole(MembershipRole.MEMBER);
        membership.setStatus(MembershipStatus.ACTIVE);
        membershipRepository.save(membership);
    }

    @Override
    public List<CommunityMemberDto> getMyCommunityMembers() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new NotFoundException("No tienes una membresía vinculada.");
        }
        Long communityId = currentUser.getMembership().getCommunity().getId();
        List<Membership> memberships = membershipRepository.findByCommunityId(communityId);
        return memberships.stream().filter(m -> MembershipStatus.ACTIVE.equals(m.getStatus()))
                .map(membershipMapper::toCommunityMemberDto)
                .collect(Collectors.toList());
    }
}
