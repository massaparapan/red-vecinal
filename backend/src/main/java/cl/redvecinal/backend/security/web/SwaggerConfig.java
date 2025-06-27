package cl.redvecinal.backend.security.web;

import io.swagger.parser.OpenAPIParser;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.parser.core.models.SwaggerParseResult;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;

import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Configuration class for Swagger/OpenAPI integration.
 * This class loads and combines multiple OpenAPI YAML files into a single OpenAPI object.
 */
@Configuration
public class SwaggerConfig {

    private static final String BASE_SWAGGER_PATH = "swagger/";
    private static final String CONTROLLERS_PATH = BASE_SWAGGER_PATH + "controllers/";
    private static final String YAML_FILE_EXTENSION = ".yaml";

    /**
     * Bean definition for the custom OpenAPI object.
     * Loads the main Swagger YAML file and merges additional controller-specific YAML files.
     *
     * @return the combined OpenAPI object
     * @throws RuntimeException if there is an error loading or parsing the Swagger configuration
     */
    @Bean
    public OpenAPI customOpenAPI() {
        try {
            OpenAPI mainApi = loadYamlFile(BASE_SWAGGER_PATH + "swagger-main.yaml");

            // Carga dinámicamente todos los archivos .yaml en la carpeta controllers
            List<String> controllerFiles = findControllerYamlFiles();

            for (String fileName : controllerFiles) {
                try {
                    OpenAPI controllerApi = loadYamlFile(fileName);
                    if (controllerApi != null) {
                        // Combina Paths
                        if (controllerApi.getPaths() != null) {
                            Objects.requireNonNull(mainApi).getPaths().putAll(controllerApi.getPaths());
                        }

                        // Combina Components (Schemas, etc.)
                        if (controllerApi.getComponents() != null &&
                                controllerApi.getComponents().getSchemas() != null) {
                            controllerApi.getComponents().getSchemas().forEach((name, schema) ->
                                    Objects.requireNonNull(mainApi).getComponents().addSchemas(name, schema)
                            );
                        }
                    }
                } catch (Exception e) {
                    System.err.println("Advertencia: No se pudo cargar el archivo de controlador " + fileName + ": " + e.getMessage());
                }
            }
            return Objects.requireNonNull(mainApi);
        } catch (Exception e) {
            throw new RuntimeException("Error al cargar configuración Swagger", e);
        }
    }

    /**
     * Loads an OpenAPI YAML file and parses it into an OpenAPI object.
     *
     * @param fileName the path to the YAML file to be loaded (e.g., "swagger/swagger-main.yaml")
     * @return the parsed OpenAPI object
     * @throws IOException if there is an error reading the file
     * @throws RuntimeException if there is an error parsing the YAML content
     */
    private OpenAPI loadYamlFile(String fileName) throws IOException {
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        Resource resource = resolver.getResource("classpath:" + fileName);

        if (!resource.exists()) {
            throw new IOException("El archivo no existe: " + fileName);
        }

        String yamlContent = new String(Files.readAllBytes(resource.getFile().toPath()));
        OpenAPIParser parser = new OpenAPIParser();
        SwaggerParseResult result = parser.readContents(yamlContent, null, null);

        if (result.getOpenAPI() != null) {
            return result.getOpenAPI();
        } else {
            throw new RuntimeException("Error al parsear " + fileName + ": " + result.getMessages());
        }
    }

    /**
     * Finds all YAML files within a specified classpath directory.
     *
     * @return A list of paths to the YAML files found.
     * @throws IOException if there is an error accessing the resources.
     */
    private List<String> findControllerYamlFiles() throws IOException {
        List<String> fileNames = new ArrayList<>();
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        // El patrón para buscar archivos YAML dentro de la carpeta especificada
        Resource[] resources = resolver.getResources("classpath:" + SwaggerConfig.CONTROLLERS_PATH + "*" + YAML_FILE_EXTENSION);

        for (Resource resource : resources) {
            // Asegúrate de que solo estamos añadiendo archivos, no directorios, y que tengan la extensión correcta
            if (resource.isFile()) {
                resource.getFilename();
                if (resource.getFilename().endsWith(YAML_FILE_EXTENSION)) {
                    fileNames.add(SwaggerConfig.CONTROLLERS_PATH + resource.getFilename());
                }
            }
        }
        return fileNames;
    }
}