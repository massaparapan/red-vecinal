package cl.redvecinal.backend.controller;

import cl.redvecinal.backend.Dtos.UserDTO;
import cl.redvecinal.backend.respository.UserRepository;
import jakarta.validation.Valid;
import jakarta.websocket.server.PathParam;
import lombok.Value;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RequestMapping("api/auth")
@RestController
public class AuthController {
    @Autowired
    AuthenticationManager authenticationManager;
    UserRepository userRepository;
    @PostMapping("signin")
    public ResponseEntity<?> registerUser (@Valid @RequestBody UserDTO userDTO) {

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        userDTO.getPhone(),
                        userDTO.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);

        return ResponseEntity.noContent().build();
    }
}
