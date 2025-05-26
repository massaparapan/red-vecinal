package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.model.CommunityModel;
import java.util.List;

public interface CommunityService {

    CommunityModel createCommunity(CommunityModel communityModel);

    /* // Not needed for now
    CommunityModel getCommunityById(Long id);
    CommunityModel updateCommunity(Long id, CommunityModel communityModel);
    void deleteCommunity(Long id);
    */

    List<CommunityModel> getCloseCommunities ( double lat, double lon);
}

