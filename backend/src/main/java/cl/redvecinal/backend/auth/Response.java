package cl.redvecinal.backend.auth;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Response {
    private boolean success;
    private Object data;
    private Error error;
}
