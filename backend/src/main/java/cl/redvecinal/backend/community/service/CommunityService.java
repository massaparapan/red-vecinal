package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.model.Community;

import java.util.List;

public interface CommunityService {

    Community createCommunity(Community communityModel);

    /* // Not needed for now
    CommunityModel getCommunityById(Long id);
    CommunityModel updateCommunity(Long id, CommunityModel communityModel);
    void deleteCommunity(Long id);
    */

    List<Community> getCloseCommunities ( double lat, double lon);
}

