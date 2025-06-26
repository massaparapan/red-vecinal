package cl.redvecinal.backend.annoucement.dto.request;

import cl.redvecinal.backend.annoucement.model.enums.AnnouncementType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AnnouncementCreateDto {
    @NotBlank(message = "El título es obligatorio")
    private String title;

    @NotBlank(message = "El contenido es obligatorio")
    private String content;

    @NotNull(message = "El tipo de anuncio es obligatorio")
    private AnnouncementType type;
}