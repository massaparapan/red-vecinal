package cl.redvecinal.backend.community.controller;

import java.util.List;

import cl.redvecinal.backend.community.model.Community;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cl.redvecinal.backend.community.dto.CommunityCreateDTO;
import cl.redvecinal.backend.community.service.CommunityServiceImpl;
import lombok.RequiredArgsConstructor;

@Tag(name = "Community Management", description = "Endpoints for managing community-related operations, such as creating communities and retrieving nearby communities.")
@RequestMapping("/api/community")
@RestController
@RequiredArgsConstructor
public class CommunityController {

    private final CommunityServiceImpl communityServiceImpl;

    @Operation(summary = "Create a new community", description = "Allows users to create a new community by providing necessary details such as name, description, location, and members count.")
    @PostMapping("/create")
    public ResponseEntity<Community> createCommunity(@RequestBody CommunityCreateDTO dto) {
        Community createdCommunity = new Community();
        createdCommunity.setName(dto.getName());
        createdCommunity.setDescription(dto.getDescription());
        createdCommunity.setLat(dto.getLat());
        createdCommunity.setLon(dto.getLon());

        Community savedCommunity = communityServiceImpl.createCommunity(createdCommunity);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedCommunity);
    }

    @Operation(summary = "Get nearby communities", description = "Retrieves a list of communities that are within a specified distance from the given latitude and longitude coordinates.")
    @GetMapping("/close")
    public ResponseEntity<List<Community>> getCloseCommunities(double lat, double lon) {
        List<Community> closeCommunities = communityServiceImpl.getCloseCommunities(lat, lon);
        return ResponseEntity.ok(closeCommunities);

    }
}
