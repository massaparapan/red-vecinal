package cl.redvecinal.backend.common.exception;

import cl.redvecinal.backend.common.handler.ApiException;

public class ConflictException extends ApiException {
    public ConflictException(String message) {
        super(message);
    }

    @Override
    public org.springframework.http.HttpStatus status() {
        return org.springframework.http.HttpStatus.CONFLICT;
    }
}
