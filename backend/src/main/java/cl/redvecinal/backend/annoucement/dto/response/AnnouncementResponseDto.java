package cl.redvecinal.backend.annoucement.dto.response;

import cl.redvecinal.backend.annoucement.model.AnnouncementType;
import cl.redvecinal.backend.user.dto.request.UserDto;
import lombok.Data;

@Data
public class AnnouncementResponseDto {
    private Long id;
    private String title;
    private String content;
    private AnnouncementType type;
    private UserDto createdBy;
}