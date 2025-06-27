package cl.redvecinal.backend.event.service;

import cl.redvecinal.backend.event.dto.request.EventCreateDto;
import cl.redvecinal.backend.event.dto.response.EventResponseDto;

import java.util.List;

public interface EventService {
    EventResponseDto create(EventCreateDto request);
    List<EventResponseDto> getAllEvents();
    void delete(Long id);
    void participateInEvent(Long id);
    List<EventResponseDto> getMyParticipations();
}