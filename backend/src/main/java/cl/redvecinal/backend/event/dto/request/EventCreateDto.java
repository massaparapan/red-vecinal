package cl.redvecinal.backend.event.dto.request;

import lombok.Data;

import java.time.LocalDate;

@Data
public class EventCreateDto {
    private String title;
    private String description;
    private String date;
    public LocalDate getDateAsLocalDate() {
        return LocalDate.parse(date);
    }
}