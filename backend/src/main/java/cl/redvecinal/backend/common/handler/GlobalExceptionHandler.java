package cl.redvecinal.backend.common.handler;

import cl.redvecinal.backend.common.dto.ErrorResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
/**
 * Global exception handler for the application.
 * This class is annotated with \@RestControllerAdvice to provide centralized exception handling
 * across all \@RestController components.
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    /**
     * Handles exceptions of type ApiException.
     * This method constructs a ResponseEntity containing an ErrorResponse object
     * with the HTTP status and error message derived from the ApiException.
     *
     * @param ex the ApiException to be handled
     * @return a ResponseEntity containing the error response with the appropriate HTTP status
     */
    @ExceptionHandler(ApiException.class)
    public ResponseEntity<ErrorResponse> handleRegisterException(ApiException ex) {
        return ResponseEntity.status(ex.status())
                .body(ErrorResponse.builder()
                        .statusCode(ex.status().value())
                        .message(ex.getMessage())
                        .build());
    }
}