package cl.redvecinal.backend.common.dto;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
public class SuccesResponse {
    @Builder.Default
    private boolean success = true;
    private Object data;
}
