package cl.redvecinal.backend.information.service.impl;

import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.config.services.IAuthContext;
import cl.redvecinal.backend.information.dto.InformationMapper;
import cl.redvecinal.backend.information.dto.request.InformationCreateDto;
import cl.redvecinal.backend.information.dto.response.InformationResponseDto;
import cl.redvecinal.backend.information.model.Information;
import cl.redvecinal.backend.information.repository.InformationRepository;
import cl.redvecinal.backend.information.service.InformationService;
import cl.redvecinal.backend.membership.model.Membership;
import cl.redvecinal.backend.user.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class InformationServiceImpl implements InformationService {
    private final InformationRepository informationRepository;

    private final IAuthContext authContext;
    private final InformationMapper informationMapper;

    @Override
    public InformationResponseDto createInformation(InformationCreateDto request) {
        User user = authContext.getCurrentUser();
        Community c = user.getMembership().getCommunity();
        Information i = informationMapper.toEntity(request);

        c.getInformations().add(i);
        i.setCommunity(c);

        Information savedInformation = informationRepository.save(i);

        return informationMapper.toDto(savedInformation);
    }

    @Override
    public List<InformationResponseDto> getMyCommunityInformations() {
        User user = authContext.getCurrentUser();
        Membership membership = user.getMembership();

        if (membership == null) {
            return List.of();
        }

        Community c = membership.getCommunity();

        return c.getInformations().stream().map(
                informationMapper::toDto
        ).toList();
    }

    @Override
    public void deleteInformation(Long id) {
        Information i = informationRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Información no encontrada"));
        informationRepository.delete(i);
    }
}
