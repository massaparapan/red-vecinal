package cl.redvecinal.backend.community.service.impl;

import cl.redvecinal.backend.common.exception.ConflictException;
import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.community.dto.request.CommunityCreateDto;
import cl.redvecinal.backend.community.dto.CommunityMapper;
import cl.redvecinal.backend.community.dto.response.CommunityPreviewDto;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.community.service.CommunityService;
import cl.redvecinal.backend.auth.service.AuthContext;
import cl.redvecinal.backend.membership.model.Membership;
import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import cl.redvecinal.backend.community.repository.CommunityRepository;

import java.util.List;

/**
 * Implementation of the CommunityService interface for managing community-related operations.
 * This service provides methods for creating communities, requesting to join communities,
 * and retrieving communities based on geographical proximity.
 */
@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {
    private final CommunityRepository communityRepository;

    private final CommunityMapper communityMapper;
    private final AuthContext authContext;

    /**
     * Creates a new community based on the provided CommunityCreateDto request.
     * The method retrieves the currently authenticated user and maps the request data to a Community entity.
     * A new membership is created for the user with a status of ACTIVE and a role of ADMIN.
     * The membership is associated with the user and the community.
     *
     * @param request the CommunityCreateDto containing the details of the community to be created
     * @return the created Community entity
     */
    @Override
    public Community create(CommunityCreateDto request) {
        User user = authContext.getCurrentUser();

        Community community = communityMapper.toEntity(request);

        Membership membership = Membership.builder()
                .user(user)
                .community(community)
                .status(MembershipStatus.ACTIVE)
                .role(MembershipRole.ADMIN)
                .build();

        user.setMembership(membership);
        return communityRepository.save(community);
    }

    /**
     * Requests to join a community by its ID.
     * If the user is not a member, it retrieves the specified community and creates a new membership
     * with a status of PENDING and a role of MEMBER. The membership is then added to the community and
     * associated with the user.
     *
     * @param communityId the ID of the community the user wants to join
     */
    @Override
    public void requestJoinCommunity(Long communityId) {
        User user = authContext.getCurrentUser();

        if (user.getMembership() != null) throw new ConflictException("Ya eres miembro de una comunidad");

        Community community = communityRepository.findById(communityId)
                .orElseThrow(() -> new NotFoundException("Comunidad no encontrada"));

        Membership m = Membership.builder()
                .user(authContext.getCurrentUser())
                .community(community)
                .status(MembershipStatus.PENDING)
                .role(MembershipRole.MEMBER)
                .build();

        community.getMemberships().add(m);
        user.setMembership(m);
        communityRepository.save(community);
    }

    /**
     * Retrieves a list of communities that are within a specified distance from a given geographical point.
     * The method calculates the distance between the provided latitude and longitude and the coordinates
     * of each community using the Haversine formula. Communities within the maximum distance are included
     * in the result.
     *
     * @return a list of CommunityPreviewDto objects representing the communities within the specified distance
     */
    @Override
    public List<CommunityPreviewDto> getCloseCommunities(double lat, double lon) {
        double maxDistance = 10.0;
        List<CommunityPreviewDto> allCommunities = communityRepository.findAll().stream()
                .map(communityMapper::toPreviewDto)
                .toList();
        return allCommunities.stream()
                .filter(community -> {
                    double communityLat = Double.parseDouble(community.getLat());
                    double communityLon = Double.parseDouble(community.getLon());
                    double distance = calculateDistance(lat, lon, communityLat, communityLon);
                    return distance <= maxDistance;
                })
                .toList();
    }

    /**
     * Calculates the distance between two geographical points using the Haversine formula.
     * The method computes the great-circle distance between two points on the Earth's surface
     * specified by their latitude and longitude in decimal degrees.
     *
     * @return the distance between the two points in kilometers
     */
    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return R * c;
    }
}