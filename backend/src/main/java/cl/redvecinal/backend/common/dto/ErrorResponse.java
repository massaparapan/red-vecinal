package cl.redvecinal.backend.common.dto;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
public class ErrorResponse {
        @Builder.Default
        private boolean success = false;
        private int statusCode;
        private String message;
}