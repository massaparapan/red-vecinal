package cl.redvecinal.backend.information.service;

import cl.redvecinal.backend.information.dto.request.InformationCreateDto;
import cl.redvecinal.backend.information.dto.response.InformationResponseDto;

import java.util.List;

public interface InformationService {
    InformationResponseDto createInformation(InformationCreateDto request);
    List<InformationResponseDto> getMyCommunityInformations();
    void deleteInformation(Long id);
}
