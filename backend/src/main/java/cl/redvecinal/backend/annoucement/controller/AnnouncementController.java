package cl.redvecinal.backend.annoucement.controller;

import cl.redvecinal.backend.annoucement.dto.request.AnnouncementCreateDto;
import cl.redvecinal.backend.annoucement.service.AnnouncementService;
import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/announcements")
@RequiredArgsConstructor
@RestController
public class AnnouncementController {
    private final AnnouncementService announcementService;

    @GetMapping("/my-community")
    public ResponseEntity<SuccessResponse> getAnnouncementsByMyCommunity() {
        return ResponseHelper.success(announcementService.getAnnouncementsByMyCommunity());
    }

    @PostMapping()
    public ResponseEntity<SuccessResponse> createAnnouncement(@RequestBody @Valid AnnouncementCreateDto request) {
        return ResponseHelper.success(announcementService.createAnnouncement(request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<SuccessResponse> deleteAnnouncement(@PathVariable Long id) {
        announcementService.deleteAnnouncement(id);
        return ResponseHelper.success("Anuncio eliminado exitosamente");
    }
}