package cl.redvecinal.backend.security.web;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web configuration class for customizing Spring MVC settings.
 * This class implements the WebMvcConfigurer interface to configure CORS (Cross-Origin Resource Sharing) mappings.
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    /**
     * Configures CORS mappings for the application.
     * Allows all origins (*) to access API endpoints under the "/api/**" path with GET and POST methods.
     *
     * @param registry the CorsRegistry to add CORS mappings
     */
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/api/**")
                .allowedOrigins("*")
                .allowedMethods("GET", "POST");
    }
}