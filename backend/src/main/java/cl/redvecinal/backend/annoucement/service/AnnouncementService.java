package cl.redvecinal.backend.annoucement.service;

import cl.redvecinal.backend.annoucement.dto.request.AnnouncementCreateDto;
import cl.redvecinal.backend.annoucement.dto.response.AnnouncementResponseDto;

import java.util.List;

public interface AnnouncementService {
    List<AnnouncementResponseDto> getAnnouncementsByMyCommunity();
    AnnouncementResponseDto createAnnouncement(AnnouncementCreateDto request);
    void deleteAnnouncement(Long id);
}