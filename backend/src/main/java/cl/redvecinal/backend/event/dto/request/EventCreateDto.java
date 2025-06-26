package cl.redvecinal.backend.event.dto.request;

import lombok.Data;

@Data
public class EventCreateDto {
    private String title;
    private String description;
}