# Laboratorio 2 de Arquitectura de Software

Backend REST desarrollado con Spring Boot a partir del proyecto base del laboratorio. Permite consultar el estado de la aplicación, su versión y datos aleatorios de naciones, monedas y aviación. El trabajo incorpora pruebas automatizadas, cobertura con JaCoCo, integración continua y contenerización con Docker.

## Información académica

| Campo | Información |
| --- | --- |
| Estudiante | Maria Camila Castañeda Piedrahita |
| Institución | Universidad de Antioquia |
| Asignatura | Arquitectura de Software |
| Profesor | Diego Botia |
| Periodo académico | 2026-2 |
| Repositorio | [Camii1234/lab2p2026](https://github.com/Camii1234/lab2p2026) |

## Tecnologías utilizadas

| Tecnología | Uso |
| --- | --- |
| Java 17 | Compilación y ejecución del backend |
| Spring Boot 4.0.8 | Aplicación web con Spring MVC |
| Maven Wrapper 3.3.4 | Ejecución reproducible de Maven 3.9.16 |
| JUnit Jupiter | Pruebas incluidas mediante el starter de pruebas de Spring Boot |
| JaCoCo 0.8.10 | Medición de cobertura y generación del reporte local |
| JavaFaker 1.0.2 | Generación de datos aleatorios |
| GitHub Actions | Pruebas y construcción del artefacto JAR |
| Docker | Construcción multietapa y ejecución del backend |

## Estructura del proyecto

```text
lab2p2026/
├── .github/workflows/build.yml
├── .mvn/wrapper/maven-wrapper.properties
├── src/
│   ├── main/
│   │   ├── java/com/udea/lab2p2026/
│   │   └── resources/application.properties
│   └── test/java/com/udea/lab2p2026/
├── .dockerignore
├── .gitignore
├── Dockerfile
├── mvnw
├── mvnw.cmd
├── pom.xml
├── README.md
└── target/                         # Generado por Maven e ignorado por Git
```

## Ejecución local

Se requiere un JDK 17 para compilar y ejecutar las pruebas, acceso a Internet para la primera descarga de Maven y dependencias, y un puerto local disponible. Para los comandos de Java y del Wrapper, `JAVA_HOME` y `PATH` deben seleccionar Java 17 en la sesión utilizada. Docker Desktop o un motor Docker activo se necesita únicamente para ejecutar la aplicación en un contenedor.

Todos los comandos se ejecutan desde la raíz del repositorio. El Wrapper utiliza la versión de Maven definida en `.mvn/wrapper/maven-wrapper.properties`.

En Windows, con PowerShell:

```powershell
java -version
.\mvnw.cmd --version
.\mvnw.cmd spring-boot:run
```

En Linux:

```bash
chmod +x mvnw
java -version
./mvnw --version
./mvnw spring-boot:run
```

La aplicación escucha en `http://localhost:8080` de forma predeterminada. Si se define la variable de entorno `PORT`, utiliza ese puerto gracias a la configuración `server.port=${PORT:8080}`. Para detener una ejecución en primer plano, utiliza `Ctrl+C`.

## Pruebas, empaquetado y cobertura

| Operación | Windows (PowerShell) | Linux |
| --- | --- | --- |
| Ejecutar las pruebas | `.\mvnw.cmd -B --no-transfer-progress test` | `./mvnw -B --no-transfer-progress test` |
| Limpiar y verificar el proyecto | `.\mvnw.cmd -B --no-transfer-progress clean verify` | `./mvnw -B --no-transfer-progress clean verify` |
| Generar el JAR ejecutable | `.\mvnw.cmd -B --no-transfer-progress package` | `./mvnw -B --no-transfer-progress package` |
| Ejecutar el JAR | `java -jar .\target\lab2p2026.jar` | `java -jar target/lab2p2026.jar` |

`clean verify` elimina la salida anterior, compila el proyecto, ejecuta las pruebas, genera el reporte de cobertura y empaqueta el JAR. El nombre final configurado en el POM es `target/lab2p2026.jar`.

Las siete pruebas verifican salud, versión, cantidades de datos, formato de los códigos de moneda y tiempo de generación de naciones. Utilizan JUnit Jupiter y `@SpringBootTest`, con llamadas directas al controlador.

JaCoCo genera el reporte durante la fase `test`. Después de ejecutar las pruebas o `clean verify`, abre `target/site/jacoco/index.html` en un navegador. Los resultados de pruebas también quedan en `target/surefire-reports/`. La cobertura requiere ejecutar las pruebas; omitirlas no genera nuevos datos de cobertura.

## Endpoints

| Método y ruta | Respuesta principal | HTTP verificado |
| --- | --- | --- |
| `GET /` | `HEALTH CHECK OK!` | 200 |
| `GET /version` | `The actual version is 1.0.0` | 200 |
| `GET /nations` | Arreglo JSON con 10 elementos | 200 |
| `GET /currencies` | Arreglo JSON con 20 elementos | 200 |
| `GET /aviation` | Arreglo JSON con 20 elementos | 200 |

Los objetos de naciones contienen `nationality`, `capitalCity`, `bandera` y `language`; las monedas contienen `name` y `code`; y los datos de aviación contienen `aircraft`, `airport` y `METAR`. Son datos sintéticos aleatorios: sus campos se generan de forma independiente y no representan un catálogo de relaciones reales.

El endpoint de versión devuelve actualmente `1.0.0`, mientras que la versión Maven del proyecto es `0.0.1-SNAPSHOT`.

## Pipeline de GitHub Actions

El workflow `CI/CD Pipeline` está definido en `.github/workflows/build.yml` y se activa mediante:

- Push a `main` o `feature/lab2-cicd`.
- Pull requests dirigidos a `main`.
- Ejecución manual con `workflow_dispatch`.

Los jobs utilizan `ubuntu-latest`, Eclipse Temurin Java 17, el Maven Wrapper y la caché de Maven integrada en `setup-java`. Los permisos del workflow se limitan a `contents: read`.

1. **`tests` — Unit tests:** concede permiso de ejecución a `mvnw`, muestra las versiones de Java y Maven, y ejecuta `./mvnw -B --no-transfer-progress clean verify` con pruebas.
2. **`build` — Build JAR:** depende de `tests` mediante `needs: tests`. Si las pruebas finalizan correctamente, ejecuta `./mvnw -B --no-transfer-progress package -DskipTests`, comprueba que exista `target/lab2p2026.jar` y lo carga como artefacto `lab2p2026-jar`, con retención de 7 días. Si falta el JAR, el job falla.

En el segundo job se omiten las pruebas porque ya fueron ejecutadas correctamente por el primero. El pipeline actual construye y conserva el artefacto; el despliegue en nube permanece pendiente.

## Contenerización con Docker

El Dockerfile mantiene dos etapas:

1. **Construcción:** utiliza `maven:3.9.16-eclipse-temurin-17`, copia el POM y el Wrapper, descarga dependencias antes de copiar `src` para aprovechar la caché, y genera `target/lab2p2026.jar` con el Wrapper.
2. **Ejecución:** utiliza `eclipse-temurin:17-jre-jammy`, copia únicamente el JAR del proyecto y ejecuta Java con el usuario `app`, UID 10001, sin privilegios de root.

El empaquetado dentro de Docker utiliza `-DskipTests`; las pruebas se ejecutan durante la validación local y en CI. `.dockerignore` excluye Git, workflows, configuración de IDE, `target`, logs y README del contexto de construcción.

La imagen declara `EXPOSE 8080`, pero el puerto efectivo de Spring Boot lo determina `PORT`, con 8080 como valor predeterminado. Para usar otro puerto se debe publicar el mismo puerto interno en el comando de Docker.

Construir la imagen desde la raíz del proyecto:

```sh
docker build --pull -t lab2p2026:local .
```

Ejecutar el contenedor en segundo plano con `PORT=10000`, usando un puerto 10000 disponible en el equipo:

```sh
docker run -d --name lab2p2026-local -e PORT=10000 -p 127.0.0.1:10000:10000 lab2p2026:local
docker logs -f lab2p2026-local
```

Espera el mensaje de arranque completo de Spring Boot antes de consultar los endpoints. `Ctrl+C` sale del seguimiento de logs sin detener el contenedor.

En Windows, con PowerShell:

```powershell
curl.exe -i http://localhost:10000/
curl.exe -i http://localhost:10000/version
curl.exe -i http://localhost:10000/nations
curl.exe -i http://localhost:10000/currencies
curl.exe -i http://localhost:10000/aviation
```

En Linux:

```bash
curl -i http://localhost:10000/
curl -i http://localhost:10000/version
curl -i http://localhost:10000/nations
curl -i http://localhost:10000/currencies
curl -i http://localhost:10000/aviation
```

Para consultar el backend ejecutado directamente con Maven o con el JAR, utiliza las mismas rutas en el puerto 8080, o en el valor definido en `PORT`.

Detener y eliminar únicamente el contenedor creado con los comandos anteriores:

```sh
docker stop lab2p2026-local
docker rm lab2p2026-local
```

La imagen `lab2p2026:local` se conserva localmente.

## Estrategia de ramas

- **`main`:** rama estable del proyecto.
- **`feature/lab2-cicd`:** rama de trabajo para el pipeline, la contenerización y la documentación del laboratorio.
- **Integración:** los cambios se integrarán posteriormente en `main` mediante un pull request, después de su revisión y de la ejecución exitosa de CI.

## Resultados verificados y estado

| Validación | Resultado |
| --- | --- |
| Pruebas con Java 17 | 7 exitosas, 0 fallos, 0 errores y 0 omitidas |
| `clean verify` | `BUILD SUCCESS` |
| JAR | `target/lab2p2026.jar` generado y ejecutable |
| Docker | Imagen `lab2p2026:local` construida correctamente |
| Backend en contenedor | Cinco endpoints con HTTP 200 y cantidades 10, 20 y 20 |
| Puerto y usuario del contenedor | `PORT=10000`, proceso Java como `app` con UID 10001 |
| GitHub Actions | Pipeline finalizado correctamente en `feature/lab2-cicd` |

La ejecución exitosa de CI puede consultarse en [GitHub Actions](https://github.com/Camii1234/lab2p2026/actions/runs/37786740796).

La validación local, Docker y CI están completadas. El despliegue en un proveedor de nube todavía está pendiente. Las configuraciones heredadas de análisis presentes en el POM no constituyen una integración activa en el pipeline actual; los servicios externos de análisis, publicación de imágenes y despliegue quedan fuera de esta etapa.

## Autoría y uso académico

Trabajo de **Maria Camila Castañeda Piedrahita**, elaborado para el Laboratorio 2 de Arquitectura de Software de la Universidad de Antioquia, periodo 2026-2, a partir del proyecto base entregado por el profesor Diego Botia.

El repositorio se presenta para uso académico. Actualmente no incluye un archivo de licencia independiente; esta documentación no atribuye una licencia de software que no haya sido definida.
