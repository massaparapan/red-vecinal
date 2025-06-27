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
@Component
public class JwtTokenProvider {
    private static final long PASSWORD_RESET_EXPIRATION = 600000;
    private static final String PHONE_NUMBER_CLAIM = "phoneNumber";

    @Value("${secret.key.jwt}")
    private String secretKey = "";
    @Value("${jwt.expiration}")
    private long jwtExpiration;
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

    public String generatePasswordResetToken(String phoneNumber) {
        Date now = new Date();
        return Jwts.builder()
                .claim(PHONE_NUMBER_CLAIM, phoneNumber)
                .issuedAt(now)
                .expiration(new Date(now.getTime() + PASSWORD_RESET_EXPIRATION))
                .signWith(getKey())
                .compact();
    }

    private SecretKey getKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }
    public String extractPhoneNumber (String token) {
        return extractClaim(token, claims -> claims.get(PHONE_NUMBER_CLAIM, String.class));
    }
    private <T> T extractClaim(String token, Function<Claims, T> claimResolver) {
        final Claims claims = extractAllClaims(token);
        return claimResolver.apply(claims);
    }
    private Claims extractAllClaims(String token) {
        return Jwts.parser()
                .verifyWith(getKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }
    public boolean validateToken(String token) {
        try {
            extractAllClaims(token);
            return !isTokenExpired(token);
        } catch (JwtException | IllegalArgumentException e) {
            throw new AuthenticationException("Token no valido");
        }
    }
    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }
    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }
}
