package cl.redvecinal.backend.event.service.impl;

import cl.redvecinal.backend.common.exception.ConflictException;
import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.auth.service.AuthContext;
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

/**
 * Implementation of the EventService interface for managing event-related operations.
 * This service provides methods for creating events, retrieving events, deleting events,
 * participating in events, and retrieving user participations.
 */
@Service
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
    private final EventRepository eventRepository;
    private final EventParticipationRepository eventParticipationRepository;

    private final EventMapper eventMapper;
    private final AuthContext authContext;

    /**
     * Creates a new event for the community of the currently authenticated user.
     *
     * @param request the EventCreateDto containing the details of the event to be created
     * @return an EventResponseDto representing the created event
     */
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

    /**
     * Retrieves all events associated with the community of the currently authenticated user.
     * The method fetches the user's community and maps its events to a list of EventResponseDto objects.
     *
     * @return a list of EventResponseDto objects representing the events of the user's community
     */
    @Override
    public List<EventResponseDto> getAllEvents() {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        return community.getEvents().stream().map(
                eventMapper::toResponseDto
        ).toList(
        );
    }

    /**
     * Deletes an event by its ID.
     * This method ensures that the currently authenticated user has permission to delete the event.
     *
     * @param id the ID of the event to be deleted
     */
    @Override
    public void delete(Long id) {
        User user = authContext.getCurrentUser();
        Community community = user.getMembership().getCommunity();
        Event event = eventRepository.findById(id).orElseThrow(
                () -> new NotFoundException("Evento no encontrado")
        );
        if (!event.getCommunity().equals(community)) {
            throw new ConflictException("No tienes permiso para eliminar este evento");
        }
        eventRepository.delete(event);
    }

    /**
     * Allows the currently authenticated user to participate in an event by its ID.
     * If the user is not already participating, a new participation is created and added to the event.
     * The updated event is then saved to the repository.
     *
     * @param id the ID of the event the user wants to participate in
     */
    @Override
    public void participateInEvent(Long id) {
        User user = authContext.getCurrentUser();
        Event event = eventRepository.findById(id).orElseThrow(
                () -> new NotFoundException("Evento no encontrado")
        );
        if (event.getParticipations().stream().anyMatch(p -> p.getUser().equals(user))) {
            throw new ConflictException("Ya estás participando en este evento");
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
