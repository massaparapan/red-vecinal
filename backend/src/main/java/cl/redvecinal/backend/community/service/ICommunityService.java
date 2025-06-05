package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.dto.CommunityCreateDto;
import cl.redvecinal.backend.community.dto.CommunityDto;
import cl.redvecinal.backend.community.model.Community;

import java.util.List;

public interface ICommunityService {
    Community create(CommunityCreateDto request);
    List<CommunityDto> getCloseCommunities (double lat, double lon);
    Community requestJoinCommunity(Long communityId);
}

