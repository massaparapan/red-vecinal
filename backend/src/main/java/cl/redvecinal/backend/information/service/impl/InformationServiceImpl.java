package cl.redvecinal.backend.information.service.impl;

import cl.redvecinal.backend.common.exception.NotFoundException;
import cl.redvecinal.backend.community.model.Community;
import cl.redvecinal.backend.auth.service.AuthContext;
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

/**
 * Implementation of the InformationService interface for managing information-related operations.
 * This service provides methods for creating, retrieving, and deleting information.
 */
@Service
@RequiredArgsConstructor
public class InformationServiceImpl implements InformationService {
    private final InformationRepository informationRepository;
    private final AuthContext authContext;
    private final InformationMapper informationMapper;

    /**
     * Creates a new information entry for the community of the currently authenticated user.
     * The method maps the request data to an Information entity, associates it with the user's community.
     *
     * @return an InformationResponseDto representing the created information
     */
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

    /**
     * Retrieves all information entries associated with the community of the currently authenticated user.
     * If the user is not a member of any community, an empty list is returned.
     *
     * @return a list of InformationResponseDto objects representing the information entries of the user's community
     */
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

    /**
     * Deletes an information entry by its ID.
     * The method retrieves the information from the repository and deletes it.
     *
     * @param id the ID of the information to be deleted
     */
    @Override
    public void deleteInformation(Long id) {
        Information i = informationRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Información no encontrada"));
        informationRepository.delete(i);
    }
}