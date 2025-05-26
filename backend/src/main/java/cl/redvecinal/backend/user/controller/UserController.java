package cl.redvecinal.backend.user.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.user.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@Tag(name = "User Management", description = "Endpoints for managing user-related operations, such as checking if a phone number is registered.")
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @Operation(summary = "Check if a phone number is registered", description = "Verifies if a given phone number is associated with a registered user.")
    @GetMapping("/consult-phoneNumber")
    public ResponseEntity<SuccesResponse> consultPhoneNumber(@RequestParam @Valid String phoneNumber) {
        return ResponseHelper.success(Map.of(
                "exists", userService.isUserRegistered(phoneNumber)
                )
        );
    }
}
