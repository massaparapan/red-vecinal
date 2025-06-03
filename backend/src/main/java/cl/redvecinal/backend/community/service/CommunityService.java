package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.dto.CommunityCreateDto;
import cl.redvecinal.backend.community.model.Community;

import java.util.List;

public interface CommunityService {
    Community create(CommunityCreateDto request);
    List<Community> getCloseCommunities (double lat, double lon);
}

