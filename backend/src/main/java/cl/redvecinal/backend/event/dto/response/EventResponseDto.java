package cl.redvecinal.backend.event.dto.response;

import cl.redvecinal.backend.user.dto.request.UserDto;
import lombok.Data;

import java.time.LocalDate;

@Data
public class EventResponseDto {
    private String id;
    private String title;
    private String description;
    private LocalDate date;
    private UserDto createdBy;
}