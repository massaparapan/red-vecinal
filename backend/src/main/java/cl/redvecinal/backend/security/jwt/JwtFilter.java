package cl.redvecinal.backend.security.jwt;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

/**
 * JWT filter for processing and validating JWT tokens in incoming HTTP requests.
 * are set in the SecurityContext for further processing.
 */
@Component
@RequiredArgsConstructor
public class JwtFilter extends OncePerRequestFilter {
    private final JwtTokenProvider jwtTokenProvider;
    private final UserDetailsService userDetailsService;

    /**
     * Processes incoming HTTP requests to validate and authenticate JWT tokens.
     * If a valid JWT is found in the request, the user's authentication details
     * are extracted and set in the SecurityContext for further processing.
     *
     * @param request     the HttpServletRequest containing the client request
     * @param response    the HttpServletResponse for the client response
     * @param filterChain the FilterChain to pass the request and response to the next filter
     * @throws ServletException if an error occurs during the filtering process
     * @throws IOException      if an I/O error occurs during the filtering process
     */
    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {
        String jwt = getJwtFromRequest(request);
        if (StringUtils.hasText(jwt) && jwtTokenProvider.validateToken(jwt)) {
            String phoneNumber = jwtTokenProvider.extractPhoneNumber(jwt);
            UserDetails userDetails = userDetailsService.loadUserByUsername(phoneNumber);

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        filterChain.doFilter(request, response);
    }

    /**
     * Extracts the JWT token from the Authorization header of the HTTP request.
     * This method checks if the Authorization header is present and starts with "Bearer ".
     * If the header is valid, it returns the JWT token by removing the "Bearer " prefix.
     * If the header is absent or does not start with "Bearer ", it returns null.
     *
     * @param request the HttpServletRequest containing the client request
     * @return the extracted JWT token, or null if the Authorization header is invalid or absent
     */
    private String getJwtFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7);
        }
        return null;
    }
}
