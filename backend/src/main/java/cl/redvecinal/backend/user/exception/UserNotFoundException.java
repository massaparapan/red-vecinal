package cl.redvecinal.backend.user.exception;

import cl.redvecinal.backend.common.exception.ApiException;
import org.springframework.http.HttpStatus;

public class UserNotFoundException extends ApiException {
    public UserNotFoundException(String message) {
        super(message);
    }
    @Override
    public HttpStatus status() {
        return HttpStatus.NOT_FOUND;
    }
}
