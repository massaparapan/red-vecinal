package cl.redvecinal.backend.common.handler;

import cl.redvecinal.backend.common.dto.ErrorResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ApiException.class)
    public ResponseEntity<ErrorResponse> handleRegisterException(ApiException ex) {
        return ResponseEntity.status(ex.status())
                .body(ErrorResponse.builder()
                        .statusCode(ex.status().value())
                        .message(ex.getMessage())
                        .build());
    }
}