package cl.redvecinal.backend.auth.exception;

public class LoginException extends RuntimeException {
    public LoginException (String message) {
        super(message);
    }
}
