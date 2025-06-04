package cl.redvecinal.backend.config;

import cl.redvecinal.backend.config.exception.TokenInvalidException;
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
    @Value("${secret.key.jwt}")
    private String secretKey = "";
    @Value("${jwt.expiration}")
    private long jwtExpiration;
    public String generateToken(User user) {
        Date now = new Date();
        return Jwts.builder()
                .claims()
                .add("phoneNumber", user.getPhoneNumber())
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
                .claim("phoneNumber", phoneNumber)
                .issuedAt(now)
                .expiration(new Date(now.getTime() + 600000))
                .signWith(getKey())
                .compact();
    }

    private SecretKey getKey() {
        byte[] keyBytes = Decoders.BASE64.decode(secretKey);
        return Keys.hmacShaKeyFor(keyBytes);
    }
    public String extractPhoneNumber (String token) {
        return extractClaim(token, claims -> claims.get("phoneNumber", String.class));
    }
    public Long extractUserId(String token) {
        return Long.parseLong(extractClaim(token, Claims::getSubject));
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
            return true;
        } catch (JwtException | IllegalArgumentException e) {
            throw new TokenInvalidException("Token no valido");
        }
    }
    private boolean isTokenExpired(String token) {
        return extractExpiration(token).before(new Date());
    }
    private Date extractExpiration(String token) {
        return extractClaim(token, Claims::getExpiration);
    }
}
