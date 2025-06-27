package cl.redvecinal.backend.common.util;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
/**
 * Utility class for creating standardized success responses.
 * This class is annotated with \@Component to allow it to be managed by the Spring container.
 * It provides a static method to generate a ResponseEntity containing a SuccessResponse object.
 */
@Component
public class ResponseHelper {

    /**
     * Private constructor to prevent instantiation of this utility class.
     */
    private ResponseHelper() {
    }

    /**
     * Creates a ResponseEntity with a SuccessResponse containing the provided data.
     *
     * @param data the data to be included in the success response
     * @return a ResponseEntity containing the SuccessResponse with the provided data
     */
    public static ResponseEntity<SuccessResponse> success(Object data) {
        return ResponseEntity.ok(
                SuccessResponse.builder()
                        .data(data)
                        .build()
        );
    }
}
