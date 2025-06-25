package cl.redvecinal.backend.events.service;

import cl.redvecinal.backend.events.dto.request.EventCreateDto;
import cl.redvecinal.backend.events.dto.response.EventResponseDto;

import java.util.List;

public interface EventService {
    EventResponseDto create(EventCreateDto request);
    List<EventResponseDto> getAllEvents();
    void delete(Long id);
    void participateInEvent(Long id);
    List<EventResponseDto> getMyParticipations();
}