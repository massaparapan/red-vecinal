package cl.redvecinal.backend.auth.exception;
public class CredentialsNotFoundException extends RuntimeException {
    public CredentialsNotFoundException(String message) {
        super(message);
    }
}
