package cl.redvecinal.backend.common.util;

import cl.redvecinal.backend.common.dto.SuccessResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
@Component
public class ResponseHelper {
    public static ResponseEntity<SuccessResponse> success (Object data) {
        return ResponseEntity.ok(
                SuccessResponse.builder()
                        .data(data)
                        .build()
        );
    }
}
