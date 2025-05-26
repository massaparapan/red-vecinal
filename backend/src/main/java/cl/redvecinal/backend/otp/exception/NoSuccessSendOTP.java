package cl.redvecinal.backend.otp.exception;

import cl.redvecinal.backend.common.exception.ApiException;

public class NoSuccessSendOTP extends ApiException {
    public NoSuccessSendOTP(String message) {
        super(message);
    }

    @Override
    public org.springframework.http.HttpStatus status() {
        return org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR;
    }
}
