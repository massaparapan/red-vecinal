package cl.redvecinal.backend.user.controller;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import cl.redvecinal.backend.common.util.ResponseHelper;
import cl.redvecinal.backend.user.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    @GetMapping("/consult-phoneNumber")
    public ResponseEntity<SuccesResponse> consultPhoneNumber(@RequestParam @Valid String phoneNumber) {
        return ResponseHelper.success(Map.of(
                "exists", userService.isUserRegistered(phoneNumber)
                )
        );
    }
}
