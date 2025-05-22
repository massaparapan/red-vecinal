package cl.redvecinal.backend.common.util;

import cl.redvecinal.backend.common.dto.SuccesResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
@Component
public class ResponseHelper {
    public static ResponseEntity<SuccesResponse> succes (Object data) {
        return ResponseEntity.ok(
                SuccesResponse.builder()
                        .data(data)
                        .build()
        );
    }
}
