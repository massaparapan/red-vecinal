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
}
