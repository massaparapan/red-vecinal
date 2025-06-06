package cl.redvecinal.backend.user.controller;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.config.JwtTokenProvider;
import cl.redvecinal.backend.user.dto.request.ResetPasswordDto;
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

    /**
     * Checks if a user is registered based on their phone number.
     * Returns a success response containing a map with a boolean value indicating
     * whether the phone number is registered.
     *
     * @param phoneNumber the phone number to check for registration
     * @return a ResponseEntity containing a SuccessResponse with a map indicating if the phone number exists
     */
    @GetMapping("/consult-phoneNumber")
    public ResponseEntity<SuccessResponse> consultPhoneNumber(@RequestParam @Valid String phoneNumber) {
        return ResponseHelper.success(Map.of("exists", userService.isUserRegistered(phoneNumber)));
    }

    /**
     * Resets the user's password after validating the reset token.
     * Ensures the phone number in the token matches the one in the request body.
     * Throws an exception if the phone numbers do not match.
     *
     * @param resetToken the token used to validate the password reset request
     * @param resetPasswordDto the data transfer object containing the phone number and new password
     * @return a ResponseEntity containing a SuccessResponse indicating the password was reset successfully
     * @throws PhoneNumberMismatchException if the phone number in the token does not match the one in the request
     */
    @PatchMapping("/reset-password")
    public ResponseEntity<SuccessResponse> resetPassword (@RequestHeader("Reset-Token") String resetToken, @RequestBody @Valid ResetPasswordDto resetPasswordDto) {
        jwtTokenProvider.validateToken(resetToken);

        String phoneNumberFromToken = jwtTokenProvider.extractPhoneNumber(resetToken);

        if (!phoneNumberFromToken.equals(resetPasswordDto.getPhoneNumber())) throw new PhoneNumberMismatchException("El número de teléfono no coincide con la solicitud");

        userService.resetPassword(resetPasswordDto.getPhoneNumber(), resetPasswordDto.getNewPassword());
        return ResponseHelper.success("Contraseña restablecida correctamente");
    }

    /**
     * Retrieves the profile of the currently authenticated user.
     * Returns a success response containing the user's profile details.
     *
     * @return a ResponseEntity containing a SuccessResponse with the current user's profile
     */
    @GetMapping("/profile/me")
    public ResponseEntity<SuccessResponse> getUserProfile() {
        return ResponseHelper.success(userService.showMyProfile());
    }

    /**
     * Retrieves the profile of a user by their ID.
     * Returns a success response containing the profile details of the specified user.
     *
     * @param id the ID of the user whose profile is to be retrieved
     * @return a ResponseEntity containing a SuccessResponse with the specified user's profile
     */
    @GetMapping("/profile/{id}")
    public ResponseEntity<SuccessResponse> getUserProfile(@PathVariable @Valid Long id) {
        return ResponseHelper.success(userService.showProfileUser(id));
    }
}
