package cl.redvecinal.backend.information.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.information.dto.request.InformationCreateDto;
import cl.redvecinal.backend.information.service.InformationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/api/informations")
@RequiredArgsConstructor
@RestController
public class InformationController {
    private final InformationService informationService;
    @GetMapping("/my-community")
    public ResponseEntity<SuccessResponse> getMyCommunity() {
        return ResponseHelper.success(informationService.getMyCommunityInformations());
    }
    @PostMapping()
    public ResponseEntity<SuccessResponse> createInformation(@RequestBody @Valid InformationCreateDto request) {
        return ResponseHelper.success(informationService.createInformation(request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<SuccessResponse> deleteInformation(@PathVariable Long id) {
        informationService.deleteInformation(id);
        return ResponseHelper.success("Eliminado con exito");
    }
}
