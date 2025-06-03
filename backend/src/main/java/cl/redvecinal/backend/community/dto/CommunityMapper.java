package cl.redvecinal.backend.community.dto;

import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.user.model.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;

@Mapper(componentModel = "spring")
public interface CommunityMapper {
    @Mappings({
            @Mapping(target = "id", ignore = true),
            @Mapping(target = "user", source = "user")
    })
    Community toEntity(CommunityCreateDto dto, User user);
}
