package cl.redvecinal.backend.user.exception;

import cl.redvecinal.backend.common.exception.ApiException;
import org.springframework.http.HttpStatus;

public class PhoneNumberMismatchException extends ApiException {
    public PhoneNumberMismatchException(String message) {
        super(message);
    }
    @Override
    public HttpStatus status() {
        return HttpStatus.CONFLICT;
    }
}
