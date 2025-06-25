package cl.redvecinal.backend.events.dto;

import cl.redvecinal.backend.events.dto.request.EventCreateDto;
import cl.redvecinal.backend.events.dto.response.EventResponseDto;
import cl.redvecinal.backend.events.model.Event;
import cl.redvecinal.backend.events.model.EventParticipation;
import cl.redvecinal.backend.user.model.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface EventMapper {
    EventResponseDto toResponseDto(Event event);
    Event toEntity(EventCreateDto eventCreateDto);
    @Mapping(target = "id", ignore = true)
    EventParticipation toParticipation(User user, Event event);
}