package cl.redvecinal.backend.events.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.events.dto.request.EventCreateDto;
import cl.redvecinal.backend.events.service.EventService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/events")
@RequiredArgsConstructor
@RestController
public class EventController {
    private final EventService eventService;

    @GetMapping("/my-community")
    public ResponseEntity<SuccessResponse> getAllEvents() {
        return ResponseHelper.success(eventService.getAllEvents());
    }
    @PostMapping()
    public ResponseEntity<SuccessResponse> createCommunity(@RequestBody @Valid EventCreateDto request) {
        return ResponseHelper.success(eventService.create(request));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<SuccessResponse> deleteEvent(@PathVariable Long id) {
        eventService.delete(id);
        return ResponseHelper.success("Evento eliminado con exito.");
    }
    @PostMapping("/participate/{id}")
    public ResponseEntity<SuccessResponse> participateInEvent(@PathVariable Long id) {
        eventService.participateInEvent(id);
        return ResponseHelper.success("Participación en el evento registrada con éxito.");
    }

    @GetMapping("my-participations")
    public ResponseEntity<SuccessResponse> getMyParticipations() {
        return ResponseHelper.success(eventService.getMyParticipations());
    }
}
