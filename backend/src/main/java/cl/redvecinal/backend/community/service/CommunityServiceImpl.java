package cl.redvecinal.backend.community.service;

import cl.redvecinal.backend.community.model.Community;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import cl.redvecinal.backend.community.repository.CommunityRepository;

import java.util.List;

@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    private CommunityRepository communityRepository;

    @Override
    public Community createCommunity(Community communityModel) {
        return communityRepository.save(communityModel);
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
