package cl.redvecinal.backend.annoucement.dto.response;

import cl.redvecinal.backend.annoucement.model.enums.AnnouncementType;
import cl.redvecinal.backend.user.dto.request.UserDto;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AnnouncementResponseDto {
    private Long id;
    private String title;
    private String content;
    private LocalDateTime createdAt;
    private AnnouncementType type;
    private UserDto createdBy;
}