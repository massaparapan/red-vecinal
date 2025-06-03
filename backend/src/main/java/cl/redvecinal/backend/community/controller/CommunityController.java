package cl.redvecinal.backend.community.controller;

import java.util.List;
import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.community.service.CommunityService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import cl.redvecinal.backend.community.dto.CommunityCreateDto;
import lombok.RequiredArgsConstructor;

@RequestMapping("/api/community")
@RestController
@RequiredArgsConstructor
public class CommunityController {

    private final CommunityService communityService;

    @PostMapping("/create")
    public ResponseEntity<SuccesResponse> createCommunity(@RequestBody CommunityCreateDto request) {
        return ResponseHelper.success(communityService.create(request));
    }

    @GetMapping("/close")
    public ResponseEntity<List<Community>> getCloseCommunities(double lat, double lon) {
        List<Community> closeCommunities = communityService.getCloseCommunities(lat, lon);
        return ResponseEntity.ok(closeCommunities);

    }
}
