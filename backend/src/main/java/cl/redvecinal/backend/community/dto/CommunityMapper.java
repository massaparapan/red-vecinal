package cl.redvecinal.backend.community.dto;

import cl.redvecinal.backend.community.model.Community;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface CommunityMapper {
    Community toEntity(CommunityCreateDto dto);
}
