package cl.redvecinal.backend.membership.exception;

import cl.redvecinal.backend.common.exception.ApiException;
import org.springframework.http.HttpStatus;

public class MembershipNotFound extends ApiException {
    public MembershipNotFound(String message) {
        super(message);
    }
    @Override
    public HttpStatus status() {
        return HttpStatus.NOT_FOUND;
    }
}
