package cl.redvecinal.backend.common.exception;

import cl.redvecinal.backend.common.handler.ApiException;

public class NotFoundException extends ApiException {
    public NotFoundException(String message) {
        super(message);
    }
    @Override
    public org.springframework.http.HttpStatus status() {
        return org.springframework.http.HttpStatus.NOT_FOUND;
    }
}
