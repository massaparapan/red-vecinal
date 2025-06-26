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

    @GetMapping("/me")
    public ResponseEntity<SuccessResponse> getMyMembership() {
        return ResponseHelper.success(membershipService.getMyMembership());
    }

    @GetMapping("/my-community")
    public ResponseEntity<SuccessResponse> getMyCommunityMemberships() {
        return ResponseHelper.success(membershipService.getMyCommunityMemberships());
    }

    @GetMapping("/my-community/members")
    public ResponseEntity<SuccessResponse> getMyCommunityMembers() {
        return ResponseHelper.success(membershipService.getMyCommunityMembers());
    }

    @DeleteMapping("/leave")
    public ResponseEntity<SuccessResponse> leaveCommunity() {
        membershipService.leaveCommunity();
        return ResponseHelper.success("Has salido de la comunidad con éxito.");
    }

    @DeleteMapping("/{membershipId}")
    public ResponseEntity<SuccessResponse> rejectMembership(@PathVariable Long membershipId) {
        membershipService.rejectMembership(membershipId);
        return ResponseHelper.success("Solicitud de membresía rechazada con éxito.");
    }

    @PatchMapping("/accept/{membershipId}")
    public ResponseEntity<SuccessResponse> acceptMembership(@PathVariable Long membershipId) {
        membershipService.acceptMembership(membershipId);
        return ResponseHelper.success("Solicitud de membresía aceptada con éxito.");
    }
    @PatchMapping("/assign-admin/{membershipId}")
    public ResponseEntity<SuccessResponse> assignAdmin(@PathVariable Long membershipId) {
        membershipService.assignAdmin(membershipId);
        return ResponseHelper.success("Membresía asignada como administrador con éxito.");
    }

    @PatchMapping("/unassign-roles/{membershipId}")
    public ResponseEntity<SuccessResponse> assignRole(@PathVariable Long membershipId) {
        membershipService.unassignRoles(membershipId);
        return ResponseHelper.success("Roles desasignado con éxito.");
    }
}
