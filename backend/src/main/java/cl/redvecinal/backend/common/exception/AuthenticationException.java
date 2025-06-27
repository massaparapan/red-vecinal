package cl.redvecinal.backend.common.exception;

import cl.redvecinal.backend.common.handler.ApiException;

public class AuthenticationException extends ApiException {

    public AuthenticationException(String message) {
        super(message);
    }

    @Override
    public org.springframework.http.HttpStatus status() {
        return org.springframework.http.HttpStatus.UNAUTHORIZED;
    }
}
