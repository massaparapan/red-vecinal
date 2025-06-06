package cl.redvecinal.backend.membership.dto;

import cl.redvecinal.backend.membership.dto.response.CommunityMemberDto;
import cl.redvecinal.backend.membership.dto.response.MembershipDto;
import cl.redvecinal.backend.membership.dto.response.MembershipRequestDto;
import cl.redvecinal.backend.membership.model.Membership;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
@Mapper(componentModel = "spring")
public interface MembershipMapper {
    MembershipDto toDto(Membership entity);
    @Mapping(source = "user", target = "userDto")
    MembershipRequestDto toRequestDto(Membership membership);
    @Mapping(target= "username", expression = "java(membership.getUser().getUsername())")
    CommunityMemberDto toCommunityMemberDto(Membership membership);
}
