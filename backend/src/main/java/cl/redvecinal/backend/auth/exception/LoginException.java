package cl.redvecinal.backend.auth.exception;

public class LoginExeption extends RuntimeException {
    public LoginExeption (String message) {
        super(message);
    }
}
