package cl.redvecinal.backend.auth.exception;

import cl.redvecinal.backend.common.exception.ApiException;
import org.springframework.http.HttpStatus;

public class IncorrectPasswordException extends ApiException {
    public IncorrectPasswordException (String message) {
        super(message);
    }

    @Override
    public HttpStatus status() {
        return HttpStatus.UNAUTHORIZED;
    }
}
