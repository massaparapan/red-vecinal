package cl.redvecinal.backend.auth.exception;
public class IncorrectPasswordException extends RuntimeException {
    public IncorrectPasswordException (String message) {
        super(message);
    }
}
