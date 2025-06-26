package cl.redvecinal.backend.user.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.config.JwtTokenProvider;
import cl.redvecinal.backend.user.dto.request.ResetPasswordDto;
import cl.redvecinal.backend.user.dto.request.UpdateProfileDto;
import cl.redvecinal.backend.user.exception.PhoneNumberMismatchException;
import cl.redvecinal.backend.user.service.IUserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
    private final IUserService userService;
    private final JwtTokenProvider jwtTokenProvider;

    @GetMapping("/consult-phoneNumber")
    public ResponseEntity<SuccessResponse> consultPhoneNumber(@RequestParam @Valid String phoneNumber) {
        return ResponseHelper.success(Map.of("exists", userService.isUserRegistered(phoneNumber)));
    }

    @PatchMapping("/reset-password")
    public ResponseEntity<SuccessResponse> resetPassword (@RequestHeader("Reset-Token") String resetToken, @RequestBody @Valid ResetPasswordDto resetPasswordDto) {
        jwtTokenProvider.validateToken(resetToken);

        String phoneNumberFromToken = jwtTokenProvider.extractPhoneNumber(resetToken);

        if (!phoneNumberFromToken.equals(resetPasswordDto.getPhoneNumber())) throw new PhoneNumberMismatchException("El número de teléfono no coincide con la solicitud");

        userService.resetPassword(resetPasswordDto.getPhoneNumber(), resetPasswordDto.getNewPassword());
        return ResponseHelper.success("Contraseña restablecida correctamente");
    }

    @GetMapping("/profile/me")
    public ResponseEntity<SuccessResponse> getUserProfile() {
        return ResponseHelper.success(userService.showMyProfile());
    }

    @GetMapping("/profile/{id}")
    public ResponseEntity<SuccessResponse> getUserProfile(@PathVariable @Valid Long id) {
        return ResponseHelper.success(userService.showProfileUser(id));
    }

    @PatchMapping("/profile/me")
    public ResponseEntity<SuccessResponse> updateUserProfile(@RequestBody @Valid UpdateProfileDto request) {
        userService.updateMyProfile(request);
        return ResponseHelper.success("Perfil actualizado correctamente");
    }
}
