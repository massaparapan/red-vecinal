package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.dto.request.CommunityCreateDto;
import cl.redvecinal.backend.community.dto.response.CommunityPreviewDto;
import cl.redvecinal.backend.community.model.Community;

import java.util.List;

public interface CommunityService {
    Community create(CommunityCreateDto request);
    List<CommunityPreviewDto> getCloseCommunities (double lat, double lon);
    void requestJoinCommunity(Long communityId);
}

