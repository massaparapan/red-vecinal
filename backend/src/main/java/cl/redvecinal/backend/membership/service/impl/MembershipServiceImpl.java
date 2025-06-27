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

/**
 * Implementation of the IMembershipService interface for managing membership-related operations.
 * This service provides methods for creating memberships, retrieving memberships, managing roles, and handling community memberships.
 */
@Service
@RequiredArgsConstructor
public class MembershipServiceImpl implements IMembershipService {
    private final MembershipRepository membershipRepository;

    private final MembershipMapper membershipMapper;
    private final AuthContext authService;

    /**
     * Creates a new membership and saves it to the repository.
     *
     * @param membership the membership to be created
     * @return the created membership
     */
    @Override
    public Membership create(Membership membership) {
        return membershipRepository.save(membership);
    }

    /**
     * Retrieves the membership of the currently authenticated user.
     *
     * @return a MembershipDto containing the membership details
     */
    @Override
    public MembershipDto getMyMembership() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new NotFoundException("No tienes una membresía vinculada.");
        }
        return membershipMapper.toDto(currentUser.getMembership());
    }

    /**
     * Retrieves the memberships of the community to which the currently authenticated user belongs.
     *
     * @return a list of MembershipRequestDto objects representing the community memberships
     */
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

    /**
     * Allows the currently authenticated user to leave their community.
     * Deletes the user's membership from the repository.
     *
     */
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

    /**
     * Rejects a membership request by its ID and deletes it from the repository.
     *
     * @param membershipId the ID of the membership to be rejected
     */
    @Override
    public void rejectMembership(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        User user = membership.getUser();
        user.setMembership(null);
        membershipRepository.delete(membership);
    }

    /**
     * Assigns the ADMIN role to a membership by its ID.
     *
     * @param membershipId the ID of the membership to be updated
     */
    @Override
    public void assignAdmin(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        membership.setRole(MembershipRole.ADMIN);
        membershipRepository.save(membership);
    }

    /**
     * Removes all roles from a membership by its ID, assigning the MEMBER role.
     *
     * @param membershipId the ID of the membership to be updated
     */
    @Override
    public void unassignRoles(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        membership.setRole(MembershipRole.MEMBER);
        membershipRepository.save(membership);
    }

    /**
     * Accepts a membership request by its ID, setting its status to ACTIVE and role to MEMBER.
     *
     * @param membershipId the ID of the membership to be accepted
     */
    @Override
    public void acceptMembership(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new NotFoundException("Membresia no encontrada."));
        membership.setRole(MembershipRole.MEMBER);
        membership.setStatus(MembershipStatus.ACTIVE);
        membershipRepository.save(membership);
    }

    /**
     * Retrieves the active members of the community to which the currently authenticated user belongs.
     *
     * @return a list of CommunityMemberDto objects representing the active community members
     */
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