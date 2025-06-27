package cl.redvecinal.backend.annoucement.service.impl;

import cl.redvecinal.backend.annoucement.dto.AnnouncementMapper;
import cl.redvecinal.backend.annoucement.dto.request.AnnouncementCreateDto;
import cl.redvecinal.backend.annoucement.dto.response.AnnouncementResponseDto;
import cl.redvecinal.backend.annoucement.model.Announcement;
import cl.redvecinal.backend.annoucement.repository.AnnouncementRepository;
import cl.redvecinal.backend.annoucement.service.AnnouncementService;
import cl.redvecinal.backend.common.exception.ConflictException;
import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.auth.service.AuthContext;
import cl.redvecinal.backend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AnnouncementServiceImpl implements AnnouncementService {
    private final AnnouncementRepository announcementRepository;

    private final AuthContext authContext;
    private final AnnouncementMapper announcementMapper;
    @Override
    public List<AnnouncementResponseDto> getAnnouncementsByMyCommunity() {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        return community.getAnnouncements().stream().map(
                announcementMapper::toResponseDto
        ).toList();
    }

    @Override
    public AnnouncementResponseDto createAnnouncement(AnnouncementCreateDto request) {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        Announcement announcement = announcementMapper.toEntity(request);
        community.getAnnouncements().add(announcement);
        announcement.setCommunity(community);
        announcement.setCreatedBy(user);
        return announcementMapper.toResponseDto(
                announcementRepository.save(announcement)
        );
    }

    @Override
    public void deleteAnnouncement(Long id) {
        Announcement announcement = announcementRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Anuncio no encontrado"));
        User user = authContext.getCurrentUser();
        if (!announcement.getCreatedBy().equals(user)) {
            throw new ConflictException("No tienes permiso para eliminar este anuncio");
        }
        announcementRepository.delete(announcement);
    }
}