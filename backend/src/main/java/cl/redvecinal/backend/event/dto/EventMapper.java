package cl.redvecinal.backend.event.dto;

import cl.redvecinal.backend.event.dto.request.EventCreateDto;
import cl.redvecinal.backend.event.dto.response.EventResponseDto;
import cl.redvecinal.backend.event.model.Event;
import cl.redvecinal.backend.event.model.EventParticipation;
import cl.redvecinal.backend.user.model.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface EventMapper {
    EventResponseDto toResponseDto(Event event);
    @Mapping(target = "date", expression = "java(eventCreateDto.getDateAsLocalDate())")
    Event toEntity(EventCreateDto eventCreateDto);
    @Mapping(target = "id", ignore = true)
    EventParticipation toParticipation(User user, Event event);
}