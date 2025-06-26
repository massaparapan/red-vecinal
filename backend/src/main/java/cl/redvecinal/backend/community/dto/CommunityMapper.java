package cl.redvecinal.backend.community.dto;

import cl.redvecinal.backend.community.dto.request.CommunityCreateDto;
import cl.redvecinal.backend.community.dto.response.CommunityPreviewDto;
import cl.redvecinal.backend.model.Community;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CommunityMapper {
    Community toEntity(CommunityCreateDto dto);
    @Mapping(target = "membersCount", expression = "java(community.getMembersCount())")
    CommunityPreviewDto toPreviewDto(Community community);
}
