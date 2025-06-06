package cl.redvecinal.backend.community.controller;

import java.util.List;
import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.community.dto.response.CommunityPreviewDto;
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
    /**
     * Creates a new community based on the provided request data.
     * The community is created and a success response is returned.
     *
     * @param request the data transfer object containing the details for creating the community
     * @return a ResponseEntity containing a SuccessResponse with the created community details
     */
    @PostMapping("/create")
    public ResponseEntity<SuccessResponse> createCommunity(@RequestBody @Valid CommunityCreateDto request) {
        return ResponseHelper.success(communityService.create(request));
    }

    /**
     * Retrieves a list of nearby communities based on the user's current location.
     * Filters communities within a specified maximum distance from the given latitude and longitude.
     *
     * @param lat the latitude of the user's current location in decimal degrees
     * @param lon the longitude of the user's current location in decimal degrees
     * @return a ResponseEntity containing a list of CommunityPreviewDto objects representing nearby communities
     */
    @GetMapping("/close")
    public ResponseEntity<List<CommunityPreviewDto>> getCloseCommunities(@RequestParam @Valid double lat, @RequestParam @Valid double lon) {
        List<CommunityPreviewDto> closeCommunities = communityService.getCloseCommunities(lat, lon);
        return ResponseEntity.ok(closeCommunities);
    }

    /**
     * Handles a user's request to join a community.
     * If the user is already a member of a community, an exception is thrown.
     * Otherwise, a membership request is created with a status of PENDING.
     *
     * @param communityId the ID of the community the user wants to join
     * @return a ResponseEntity containing a SuccessResponse indicating the request was sent successfully
     */
    @PostMapping("/request-join")
    public ResponseEntity<SuccessResponse> requestJoinCommunity(@RequestParam Long communityId) {
        communityService.requestJoinCommunity(communityId);
        return ResponseHelper.success("Solicitud enviada a la comunidad con éxito.");
    }
}
