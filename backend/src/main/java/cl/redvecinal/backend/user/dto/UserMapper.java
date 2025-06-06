package cl.redvecinal.backend.user.dto;

import cl.redvecinal.backend.user.dto.response.UserMyProfileDto;
import cl.redvecinal.backend.user.dto.response.UserProfileDto;
import cl.redvecinal.backend.user.model.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface UserMapper {
    @Mapping(target = "nameOfCommunity", expression = "java(user.getNameOfCommunity())")
    UserMyProfileDto toUserMyProfileDto(User user);
    UserProfileDto toUserProfileDto(User user);
}
