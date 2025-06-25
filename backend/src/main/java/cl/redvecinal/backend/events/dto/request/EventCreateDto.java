package cl.redvecinal.backend.events.dto.request;

import lombok.Data;

@Data
public class EventCreateDto {
    private String title;
    private String description;
}