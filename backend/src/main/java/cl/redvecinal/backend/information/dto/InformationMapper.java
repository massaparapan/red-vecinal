package cl.redvecinal.backend.information.dto;

import cl.redvecinal.backend.information.dto.request.InformationCreateDto;
import cl.redvecinal.backend.information.dto.response.InformationResponseDto;
import cl.redvecinal.backend.information.model.Information;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface InformationMapper {
    InformationResponseDto toDto(Information information);
    Information toEntity(InformationCreateDto request);
}
