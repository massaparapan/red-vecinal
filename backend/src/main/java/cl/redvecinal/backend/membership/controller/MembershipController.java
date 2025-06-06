package cl.redvecinal.backend.membership.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.membership.service.IMembershipService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/memberships")
@RequiredArgsConstructor
@RestController
public class MembershipController {
    private final IMembershipService membershipService;

    /**
     * Retrieves the membership details of the currently authenticated user.
     * Returns a success response containing the user's membership information.
     *
     * @return a ResponseEntity containing a SuccessResponse with the user's membership details
     */
    @GetMapping("/me")
    public ResponseEntity<SuccessResponse> getMyMembership() {
        return ResponseHelper.success(membershipService.getMyMembership());
    }

    /**
     * Retrieves the memberships of the communities the currently authenticated user belongs to.
     * Returns a success response containing the list of community memberships.
     *
     * @return a ResponseEntity containing a SuccessResponse with the user's community memberships
     */
    @GetMapping("/my-community")
    public ResponseEntity<SuccessResponse> getMyCommunityMemberships() {
        return ResponseHelper.success(membershipService.getMyCommunityMemberships());
    }

    /**
     * Retrieves the members of the community the currently authenticated user belongs to.
     * Returns a success response containing the list of community members.
     *
     * @return a ResponseEntity containing a SuccessResponse with the community members
     */
    @GetMapping("/my-community/members")
    public ResponseEntity<SuccessResponse> getMyCommunityMembers() {
        return ResponseHelper.success(membershipService.getMyCommunityMembers());
    }

    /**
     * Allows the currently authenticated user to leave their community.
     * Returns a success response indicating the user has successfully left the community.
     *
     * @return a ResponseEntity containing a SuccessResponse with a success message
     */
    @DeleteMapping("/leave")
    public ResponseEntity<SuccessResponse> leaveCommunity() {
        membershipService.leaveCommunity();
        return ResponseHelper.success("Has salido de la comunidad con éxito.");
    }

    /**
     * Rejects a membership request by its ID.
     * Returns a success response indicating the membership request was successfully rejected.
     *
     * @param membershipId the ID of the membership request to reject
     * @return a ResponseEntity containing a SuccessResponse with a success message
     */
    @DeleteMapping("/{membershipId}")
    public ResponseEntity<SuccessResponse> rejectMembership(@PathVariable Long membershipId) {
        membershipService.rejectMembership(membershipId);
        return ResponseHelper.success("Solicitud de membresía rechazada con éxito.");
    }

    /**
     * Accepts a membership request by its ID.
     * Returns a success response indicating the membership request was successfully accepted.
     *
     * @param membershipId the ID of the membership request to accept
     * @return a ResponseEntity containing a SuccessResponse with a success message
     */
    @PatchMapping("/accept/{membershipId}")
    public ResponseEntity<SuccessResponse> acceptMembership(@PathVariable Long membershipId) {
        membershipService.acceptMembership(membershipId);
        return ResponseHelper.success("Solicitud de membresía aceptada con éxito.");
    }

    /**
     * Assigns administrator privileges to a membership by its ID.
     * Returns a success response indicating the membership was successfully assigned as an administrator.
     *
     * @param membershipId the ID of the membership to assign as administrator
     * @return a ResponseEntity containing a SuccessResponse with a success message
     */
    @PatchMapping("/assign-admin/{membershipId}")
    public ResponseEntity<SuccessResponse> assignAdmin(@PathVariable Long membershipId) {
        membershipService.assignAdmin(membershipId);
        return ResponseHelper.success("Membresía asignada como administrador con éxito.");
    }

    /**
     * Unassigns all roles from a membership by its ID.
     * Returns a success response indicating the roles were successfully unassigned.
     *
     * @param membershipId the ID of the membership to unassign roles from
     * @return a ResponseEntity containing a SuccessResponse with a success message
     */
    @PatchMapping("/unassign-roles/{membershipId}")
    public ResponseEntity<SuccessResponse> assignRole(@PathVariable Long membershipId) {
        membershipService.unassignRoles(membershipId);
        return ResponseHelper.success("Roles desasignado con éxito.");
    }
}
