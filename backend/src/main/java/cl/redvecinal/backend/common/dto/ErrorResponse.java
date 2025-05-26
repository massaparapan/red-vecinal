package cl.redvecinal.backend.common.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;


@Schema(description = "Response object for error handling in the application.")
@Data
@Builder
@AllArgsConstructor
public class ErrorResponse {
        @Schema(description = "Indicates whether the operation was successful or not. Defaults to false.")
        @Builder.Default
        private boolean success = false;

        @Schema(description = "HTTP status code representing the error. This field is required.")
        private int statusCode;

        @Schema(description = "Error message providing details about the error. This field is required.")
        private String message;
}