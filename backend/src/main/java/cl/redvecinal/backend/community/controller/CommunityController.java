package cl.redvecinal.backend.community.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.community.service.ICommunityService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import cl.redvecinal.backend.community.dto.request.CommunityCreateDto;
import lombok.RequiredArgsConstructor;

@RequestMapping("/api/communities")
@RestController
@RequiredArgsConstructor
public class CommunityController {
    private final ICommunityService communityService;

    @PostMapping("/create")
    public ResponseEntity<SuccessResponse> createCommunity(@RequestBody @Valid CommunityCreateDto request) {
        return ResponseHelper.success(communityService.create(request));
    }

    @GetMapping("/close")
    public ResponseEntity<SuccessResponse> getCloseCommunities(@RequestParam @Valid double lat, @RequestParam @Valid double lon) {
        return ResponseHelper.success(communityService.getCloseCommunities(lat, lon));
    }

    @PostMapping("/request-join")
    public ResponseEntity<SuccessResponse> requestJoinCommunity(@RequestParam Long communityId) {
        communityService.requestJoinCommunity(communityId);
        return ResponseHelper.success("Solicitud enviada a la comunidad con éxito.");
    }
}
