package cl.redvecinal.backend.common.dto;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
public class SuccessResponse {
    @Builder.Default
    private boolean success = true;
    private Object data;
}