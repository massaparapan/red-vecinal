package cl.redvecinal.backend.security.web;

import io.swagger.parser.OpenAPIParser;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.parser.core.models.SwaggerParseResult;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;

@Configuration
public class SwaggerConfig {

    @Bean
    public OpenAPI customOpenAPI() {
        try {
            OpenAPI mainApi = loadYamlFile("swagger/swagger-main.yaml");

            List<String> controllerFiles = Arrays.asList(
                    "swagger/user/user-controller.yaml"
            );

            for (String fileName : controllerFiles) {
                try {
                    OpenAPI controllerApi = loadYamlFile(fileName);
                    if (controllerApi != null && controllerApi.getPaths() != null) {
                        controllerApi.getPaths().forEach((path, pathItem) -> {
                            mainApi.getPaths().addPathItem(path, pathItem);
                        });

                        if (controllerApi.getComponents() != null &&
                                controllerApi.getComponents().getSchemas() != null) {
                            controllerApi.getComponents().getSchemas().forEach((name, schema) -> {
                                mainApi.getComponents().addSchemas(name, schema);
                            });
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Warning: No se pudo cargar " + fileName + ": " + e.getMessage());
                }
            }
            return mainApi;
        } catch (Exception e) {
            throw new RuntimeException("Error al cargar configuración Swagger", e);
        }
    }

    private OpenAPI loadYamlFile(String fileName) throws IOException {
        ClassPathResource resource = new ClassPathResource(fileName);
        if (!resource.exists()) {
            return null;
        }

        String yamlContent = new String(Files.readAllBytes(Paths.get(resource.getURI())));
        OpenAPIParser parser = new OpenAPIParser();
        SwaggerParseResult result = parser.readContents(yamlContent, null, null);

        if (result.getOpenAPI() != null) {
            return result.getOpenAPI();
        } else {
            throw new RuntimeException("Error al parsear " + fileName + ": " + result.getMessages());
        }
    }
}