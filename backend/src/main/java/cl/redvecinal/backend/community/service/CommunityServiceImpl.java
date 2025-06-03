package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.dto.CommunityCreateDto;
import cl.redvecinal.backend.community.dto.CommunityMapper;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.config.CustomUserDetails;
import cl.redvecinal.backend.model.Membership;
import cl.redvecinal.backend.model.MembershipRole;
import cl.redvecinal.backend.model.MembershipStatus;
import cl.redvecinal.backend.user.model.User;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import cl.redvecinal.backend.community.repository.CommunityRepository;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService {
    private final CommunityRepository communityRepository;
    private final CommunityMapper communityMapper;
    @Override
    public Community create(CommunityCreateDto request) {
        CustomUserDetails authentication = (CustomUserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = authentication.user();

        if (authentication.user().getMembership() != null) {
            throw new IllegalStateException("You are already a member of a community.");
        }

        Community community = communityMapper.toEntity(request, user);
        Membership membership = Membership.builder()
                .user(user)
                .community(community)
                .status(MembershipStatus.ACTIVE)
                .role(MembershipRole.ADMIN)
                .build();

        user.setMembership(membership);
        community.getMemberships().add(membership);
        return communityRepository.save(community);
    }

    @Override
    public List<Community> getCloseCommunities(double lat, double lon) {
        double maxDistance = 10.0;
        List<Community> allCommunities = communityRepository.findAll();

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
