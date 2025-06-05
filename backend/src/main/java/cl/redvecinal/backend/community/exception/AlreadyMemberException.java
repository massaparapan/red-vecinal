package cl.redvecinal.backend.community.exception;

import cl.redvecinal.backend.common.exception.ApiException;
import org.springframework.http.HttpStatus;

public class AlreadyMemberException extends ApiException {
    public AlreadyMemberException(String message) {
        super(message);
    }
    @Override
    public HttpStatus status() {
        return HttpStatus.CONFLICT;
    }
}
