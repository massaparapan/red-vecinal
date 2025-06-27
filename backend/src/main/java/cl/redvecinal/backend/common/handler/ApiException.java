package cl.redvecinal.backend.common.handler;

import org.springframework.http.HttpStatus;

public abstract class ApiException extends RuntimeException {
    public ApiException(String message) {
        super(message);
    }
    public abstract HttpStatus status();
}
