package cl.redvecinal.backend.common.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;


@Schema(description = "Response object for successful operations in the application.")
@Data
@Builder
@AllArgsConstructor
public class SuccessResponse {

    @Schema(description = "Indicates whether the operation was successful or not. Defaults to true.")
    @Builder.Default
    private boolean success = true;

    @Schema(description = "HTTP status code representing the success of the operation. This field is required.")
    private Object data;
}