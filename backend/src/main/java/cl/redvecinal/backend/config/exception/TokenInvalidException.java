package cl.redvecinal.backend.config.exception;

import cl.redvecinal.backend.common.exception.ApiException;
import org.springframework.http.HttpStatus;

public class TokenInvalidException extends ApiException {
    public TokenInvalidException(String message) {
        super(message);
    }
    @Override
    public HttpStatus status() {
        return HttpStatus.CONFLICT;
    }
}
