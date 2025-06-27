package cl.redvecinal.backend.common.handler;

import org.springframework.http.HttpStatus;

/**
 * Abstract base class for custom API exceptions.
 * This class extends RuntimeException and provides a structure for defining
 * custom exceptions with an associated HTTP status.
 */
public abstract class ApiException extends RuntimeException {

    /**
     * Constructs a new ApiException with the specified detail message.
     *
     * @param message the detail message for the exception
     */
    public ApiException(String message) {
        super(message);
    }

    /**
     * Abstract method to retrieve the HTTP status associated with the exception.
     *
     * @return the HTTP status of the exception
     */
    public abstract HttpStatus status();
}
