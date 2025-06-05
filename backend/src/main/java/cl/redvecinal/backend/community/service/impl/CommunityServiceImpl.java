package cl.redvecinal.backend.community.service.impl;

import cl.redvecinal.backend.community.dto.request.CommunityCreateDto;
import cl.redvecinal.backend.community.dto.CommunityMapper;
import cl.redvecinal.backend.community.dto.response.CommunityPreviewDto;
import cl.redvecinal.backend.community.exception.AlreadyMemberException;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.community.service.ICommunityService;
import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.membership.model.Membership;
import cl.redvecinal.backend.membership.model.enums.MembershipRole;
import cl.redvecinal.backend.membership.model.enums.MembershipStatus;
import cl.redvecinal.backend.user.model.User;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import cl.redvecinal.backend.community.repository.CommunityRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements ICommunityService {
    private final CommunityRepository communityRepository;

    private final CommunityMapper communityMapper;
    private final IAuthContext authContext;
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
    @Override
    public void requestJoinCommunity(Long communityId) {
        User user = authContext.getCurrentUser();

        if (user.getMembership() != null) throw new AlreadyMemberException("Ya eres miembro de una comunidad");

        Community community = communityRepository.findById(communityId)
                .orElseThrow(() -> new EntityNotFoundException("Comunidad no encontrada"));

        Membership m = Membership.builder()
                .user(authContext.getCurrentUser())
                .community(community)
                .status(MembershipStatus.PENDING)
                .role(MembershipRole.MEMBER)
                .build();

        community.getMemberships().add(m);
        user.setMembership(m);
    }
    @Override
    public List<CommunityPreviewDto> getCloseCommunities(double lat, double lon) {
        double maxDistance = 10.0;
        List<CommunityPreviewDto> allCommunities = communityRepository.findAll().stream().map(communityMapper::toPreviewDto).toList();
        return allCommunities.stream()
                .filter(community -> {
                    double communityLat = Double.parseDouble(community.getLat());
                    double communityLon = Double.parseDouble(community.getLon());
                    double distance = calculateDistance(lat, lon, communityLat, communityLon);
                    return distance <= maxDistance;
                })
                .toList();
    }
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
