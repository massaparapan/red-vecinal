package cl.redvecinal.backend.membership.service.impl;

import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.membership.dto.response.CommunityMemberDto;
import cl.redvecinal.backend.membership.dto.response.MembershipDto;
import cl.redvecinal.backend.membership.dto.MembershipMapper;
import cl.redvecinal.backend.membership.dto.response.MembershipRequestDto;
import cl.redvecinal.backend.membership.exception.MembershipNotFound;
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
    private final IAuthContext authService;
    /**
     * Creates a new membership by saving it to the repository.
     *
     * @param membership the Membership object to be created
     * @return the saved Membership object
     */
    @Override
    public Membership create(Membership membership){
        return membershipRepository.save(membership);
    }
    /**
     * Retrieves the membership details of the currently authenticated user.
     * Throws an exception if the user does not have a membership linked.
     *
     * @return a MembershipDto containing the details of the user's membership
     * @throws MembershipNotFound if the user does not have a membership linked
     */
    @Override
    public MembershipDto getMyMembership() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new MembershipNotFound("No tienes una membresía vinculada.");
        }
        return membershipMapper.toDto(currentUser.getMembership());
    }

    /**
     * Retrieves the memberships of the communities the currently authenticated user belongs to.
     * Throws an exception if the user does not have a membership linked.
     *
     * @return a list of MembershipRequestDto containing the community memberships
     * @throws MembershipNotFound if the user does not have a membership linked
     */
    @Override
    public List<MembershipRequestDto> getMyCommunityMemberships() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new MembershipNotFound("No tienes una membresía vinculada.");
        }
        Long communityId = currentUser.getMembership().getCommunity().getId();
        List<Membership> memberships = membershipRepository.findByCommunityId(communityId);
        return memberships.stream()
                .map(membershipMapper::toRequestDto)
                .toList();
    }

    /**
     * Allows the currently authenticated user to leave their community.
     * Deletes the user's membership and unlinks it from the user.
     * Throws an exception if the user does not have a membership linked.
     *
     * @throws MembershipNotFound if the user does not have a membership linked
     */
    @Override
    public void leaveCommunity() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new MembershipNotFound("No tienes una membresía vinculada.");
        }
        Membership membership = currentUser.getMembership();
        currentUser.setMembership(null);
        membershipRepository.delete(membership);
    }

    /**
     * Rejects a membership by its ID.
     * Deletes the membership from the repository.
     * Throws an exception if the membership is not found.
     *
     * @param membershipId the ID of the membership to reject
     * @throws MembershipNotFound if the membership is not found
     */
    @Override
    public void rejectMembership(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new MembershipNotFound("Membresia no encontrada."));

        membershipRepository.delete(membership);
    }

    /**
     * Assigns administrator privileges to a membership by its ID.
     * Updates the membership role to ADMIN.
     * Throws an exception if the membership is not found.
     *
     * @param membershipId the ID of the membership to assign as administrator
     * @throws MembershipNotFound if the membership is not found
     */
    @Override
    public void assignAdmin(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new MembershipNotFound("Membresia no encontrada."));
        membership.setRole(MembershipRole.ADMIN);
        membershipRepository.save(membership);
    }

    /**
     * Unassigns all roles from a membership by its ID.
     * Updates the membership role to MEMBER.
     * Throws an exception if the membership is not found.
     *
     * @param membershipId the ID of the membership to unassign roles from
     * @throws MembershipNotFound if the membership is not found
     */
    @Override
    public void unassignRoles(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new MembershipNotFound("Membresia no encontrada."));
        membership.setRole(MembershipRole.MEMBER);
        membershipRepository.save(membership);
    }

    /**
     * Accepts a membership by its ID.
     * Updates the membership role to MEMBER.
     * Throws an exception if the membership is not found.
     *
     * @param membershipId the ID of the membership to accept
     * @throws MembershipNotFound if the membership is not found
     */
    @Override
    public void acceptMembership(Long membershipId) {
        Membership membership = membershipRepository.findById(membershipId)
                .orElseThrow(() -> new MembershipNotFound("Membresia no encontrada."));
        membership.setRole(MembershipRole.MEMBER);
        membershipRepository.save(membership);
    }

    /**
     * Retrieves the members of the community the currently authenticated user belongs to.
     * Filters the memberships to include only active members.
     * Throws an exception if the user does not have a membership linked.
     *
     * @return a list of CommunityMemberDto containing the community members
     * @throws MembershipNotFound if the user does not have a membership linked
     */
    @Override
    public List<CommunityMemberDto> getMyCommunityMembers() {
        User currentUser = authService.getCurrentUser();
        if (currentUser.getMembership() == null) {
            throw new MembershipNotFound("No tienes una membresía vinculada.");
        }
        Long communityId = currentUser.getMembership().getCommunity().getId();
        List<Membership> memberships = membershipRepository.findByCommunityId(communityId);
        return memberships.stream().filter(m -> MembershipStatus.ACTIVE.equals(m.getStatus()))
                .map(membershipMapper::toCommunityMemberDto)
                .collect(Collectors.toList());
    }
}
