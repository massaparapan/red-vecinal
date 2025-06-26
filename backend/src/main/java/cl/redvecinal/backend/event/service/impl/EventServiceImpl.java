package cl.redvecinal.backend.event.service.impl;

import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.event.dto.request.EventCreateDto;
import cl.redvecinal.backend.event.dto.EventMapper;
import cl.redvecinal.backend.event.dto.response.EventResponseDto;
import cl.redvecinal.backend.event.model.Event;
import cl.redvecinal.backend.event.model.EventParticipation;
import cl.redvecinal.backend.event.repository.EventParticipationRepository;
import cl.redvecinal.backend.event.repository.EventRepository;
import cl.redvecinal.backend.event.service.EventService;
import cl.redvecinal.backend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
    private final EventRepository eventRepository;
    private final EventParticipationRepository eventParticipationRepository;

    private final EventMapper eventMapper;
    private final IAuthContext authContext;
    @Override
    public EventResponseDto create(EventCreateDto request) {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        Event event = eventMapper.toEntity(request);
        community.getEvents().add(event);
        event.setCommunity(community);
        event.setCreatedBy(user);
        return eventMapper.toResponseDto(eventRepository.save(event));
    }

    @Override
    public List<EventResponseDto> getAllEvents() {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        return community.getEvents().stream().map(
                eventMapper::toResponseDto
        ).toList(
        );
    }

    @Override
    public void delete(Long id) {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        Event event = eventRepository.findById(id).orElseThrow(
                () -> new IllegalArgumentException("Evento no encontrado")
        );
        if (!event.getCommunity().equals(community)) {
            throw new IllegalArgumentException("No tienes permiso para eliminar este evento");
        }
        eventRepository.delete(event);
    }

    @Override
    public void participateInEvent(Long id) {
        User user = authContext.getCurrentUser();
        Event event = eventRepository.findById(id).orElseThrow(
                () -> new IllegalArgumentException("Evento no encontrado")
        );
        if (event.getParticipations().stream().anyMatch(p -> p.getUser().equals(user))) {
            throw new IllegalArgumentException("Ya estás participando en este evento");
        }
        event.getParticipations().add(eventMapper.toParticipation(user, event));
        eventRepository.save(event);
    }

    @Override
    public List<EventResponseDto> getMyParticipations() {
        User user = authContext.getCurrentUser();
        List<EventParticipation> participations = eventParticipationRepository.findByUserId(user.getId());
        List<Event> events = participations.stream()
                .map(EventParticipation::getEvent)
                .toList();
        return events.stream().map(
                eventMapper::toResponseDto
        ).toList();
    }
}
