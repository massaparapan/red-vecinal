package cl.redvecinal.backend.common.exception;

import cl.redvecinal.backend.auth.exception.CredentialsNotFoundException;
import cl.redvecinal.backend.auth.exception.PhoneAlreadyExistsException;
import cl.redvecinal.backend.common.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(CredentialsNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleRegisterException(CredentialsNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ErrorResponse.builder()
                        .statusCode(HttpStatus.NOT_FOUND.value())
                        .message(ex.getMessage())
                        .build());
    }

    @ExceptionHandler(PhoneAlreadyExistsException.class)
    public ResponseEntity<ErrorResponse> handleRegisterException(PhoneAlreadyExistsException ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ErrorResponse.builder()
                        .statusCode(HttpStatus.CONFLICT.value())
                        .message(ex.getMessage())
                        .build());
    }
}