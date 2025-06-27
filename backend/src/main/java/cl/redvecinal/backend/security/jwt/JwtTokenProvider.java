package cl.redvecinal.backend.security.jwt;

import cl.redvecinal.backend.common.exception.AuthenticationException;
import cl.redvecinal.backend.user.model.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;
import io.jsonwebtoken.io.Decoders;
import java.util.function.Function;

/**
 * Component responsible for handling JWT token operations such as generation, validation, and extraction of claims.
 */
@Component
public class JwtTokenProvider {
    private static final long PASSWORD_RESET_EXPIRATION = 600000;
    private static final String PHONE_NUMBER_CLAIM = "phoneNumber";

    @Value("${secret.key.jwt}")
    private String secretKey = "";
    @Value("${jwt.expiration}")
    private long jwtExpiration;

    /**
     * Generates a JWT token for the given user.
     *
     * @param user the user for whom the token is generated
     * @return the generated JWT token
     */
    public String generateToken(User user) {
        Date now = new Date();
        return Jwts.builder()
                .claims()
                .add(PHONE_NUMBER_CLAIM, user.getPhoneNumber())
                .subject(String.valueOf(user.getId()))
                .issuedAt(now)
                .expiration(new Date(now.getTime() + jwtExpiration))
                .and()
                .signWith(getKey())
                .compact();
    }

    /**
     * Generates a password reset JWT token for the given phone number.
     *
     * @param phoneNumber the phone number for which the token is generated
     * @return the generated password reset JWT token
     */
    public String generatePasswordResetToken(String phoneNumber) {
        Date now = new Date();
        return Jwts.builder()
                .claim(PHONE_NUMBER_CLAIM, phoneNumber)
                .issuedAt(now)
                .expiration(new Date(now.getTime() + PASSWORD_RESET_EXPIRATION))
                .signWith(getKey())
                .compact();
    }

    /**
     * Decodes the secret key and returns it as a SecretKey object.
     *
     * @return the decoded SecretKey
     */
    private SecretKey getKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    /**
     * Extracts the phone number claim from the given JWT token.
     *
     * @param token the JWT token
     * @return the extracted phone number
     */
    public String extractPhoneNumber (String token) {
        return extractClaim(token, claims -> claims.get(PHONE_NUMBER_CLAIM, String.class));
    }

    /**
     * Extracts a specific claim from the given JWT token using a claim resolver function.
     *
     * @param token the JWT token
     * @param claimResolver the function to resolve the claim
     * @param <T> the type of the claim
     * @return the extracted claim
     */
    private <T> T extractClaim(String token, Function<Claims, T> claimResolver) {
        final Claims claims = extractAllClaims(token);
        return claimResolver.apply(claims);
    }

    /**
     * Extracts all claims from the given JWT token.
     *
     * @param token the JWT token
     * @return the extracted claims
     */
    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    /**
     * Validates the given JWT token.
     *
     * @param token the JWT token to validate
     * @return true if the token is valid, false otherwise
     * @throws AuthenticationException if the token is invalid
     */
    public boolean validateToken(String token) {
        try {
            extractAllClaims(token);
            return !isTokenExpired(token);
        } catch (JwtException | IllegalArgumentException e) {
            throw new AuthenticationException("Token no valido");
        }
    }
    /**
     * Checks if the given JWT token is expired.
     *
     * @param token the JWT token
     * @return true if the token is expired, false otherwise
     */
    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }
    /**
     *
     * @param token the JWT token
     * @return the expiration date
     */
    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }
}
