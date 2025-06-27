package cl.redvecinal.backend.annoucement.dto;

import cl.redvecinal.backend.annoucement.dto.request.AnnouncementCreateDto;
import cl.redvecinal.backend.annoucement.dto.response.AnnouncementResponseDto;
import cl.redvecinal.backend.annoucement.model.Announcement;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface AnnouncementMapper {
    AnnouncementResponseDto toResponseDto(Announcement announcement);
    Announcement toEntity(AnnouncementCreateDto request);
}