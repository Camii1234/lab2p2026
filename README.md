# Laboratorio 2 de Arquitectura de Software

[![Quality Gate](https://sonarcloud.io/api/project_badges/quality_gate?project=Camii1234_lab2p2026)](https://sonarcloud.io/summary/new_code?id=Camii1234_lab2p2026)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=Camii1234_lab2p2026&metric=coverage)](https://sonarcloud.io/summary/new_code?id=Camii1234_lab2p2026)
[![Known Vulnerabilities](https://snyk.io/test/github/Camii1234/lab2p2026/badge.svg)](https://snyk.io/test/github/Camii1234/lab2p2026)
[![CI/CD Pipeline](https://github.com/Camii1234/lab2p2026/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/Camii1234/lab2p2026/actions/workflows/build.yml)

Backend REST desarrollado con Spring Boot a partir del proyecto base del laboratorio. Permite consultar el estado de la aplicación, su versión y datos aleatorios de naciones, monedas y aviación. El trabajo incorpora pruebas automatizadas, cobertura con JaCoCo, análisis de calidad con SonarQube Cloud, integración continua, contenerización con Docker y despliegue en Render.

Backend público: [lab2p2026-maria-camila.onrender.com](https://lab2p2026-maria-camila.onrender.com).

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
| SonarQube Cloud | Análisis de calidad y verificación del Quality Gate |
| JavaFaker 1.0.2 | Generación de datos aleatorios |
| GitHub Actions | Pruebas, análisis de calidad, construcción del artefacto JAR y solicitud de despliegue |
| Docker | Construcción multietapa y ejecución del backend |
| Render | Alojamiento del backend mediante Docker |

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

La medición inicial de JaCoCo registró:

| Métrica | Cobertura inicial |
| --- | --- |
| Líneas | 91,89 % |
| Instrucciones | 94,67 % |
| Ramas | 100 % |
| Métodos | 77,78 % |
| Clases | 100 % |

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

- Push a `main` o a cualquier rama que coincida con `feature/**`.
- Pull requests dirigidos a `main`.
- Ejecución manual con `workflow_dispatch`.

Los jobs de pruebas, análisis y construcción utilizan `ubuntu-latest`, Eclipse Temurin Java 17, el Maven Wrapper y la caché de Maven integrada en `setup-java`. Los permisos del workflow se limitan a `contents: read`.

1. **`tests` — Unit tests:** concede permiso de ejecución a `mvnw`, muestra las versiones de Java y Maven, y ejecuta `./mvnw -B --no-transfer-progress clean verify` con pruebas.
2. **`sonar` — SonarQube Cloud analysis:** depende de `tests` mediante `needs: tests`, obtiene el historial completo con `fetch-depth: 0` y ejecuta `clean verify` y el análisis con el Maven Wrapper. Espera el resultado del Quality Gate mediante `-Dsonar.qualitygate.wait=true`; si el análisis falla o el Quality Gate no se aprueba, los jobs siguientes no se ejecutan.
3. **`build` — Build JAR:** depende de `sonar` mediante `needs: sonar`. Solo si el análisis finaliza correctamente y el Quality Gate es aprobado, ejecuta `./mvnw -B --no-transfer-progress package -DskipTests`, comprueba que exista `target/lab2p2026.jar` y lo carga como artefacto `lab2p2026-jar`, con retención de 7 días. Si falta el JAR, el job falla.
4. **`deploy` — Deploy to Render:** depende de `build` y solo se ejecuta después de que los jobs anteriores finalicen correctamente y si el evento es un push a `main`, con la condición `github.event_name == 'push' && github.ref == 'refs/heads/main'`. Comprueba que el secreto de repositorio `RENDER_DEPLOY_HOOK_URL` no esté vacío y solicita el despliegue mediante un POST, sin imprimir su valor ni el cuerpo de la respuesta.

La secuencia configurada es **`tests → sonar → build → deploy`**. En `build` se omiten las pruebas porque ya fueron ejecutadas correctamente en los jobs anteriores.

| Evento | Comportamiento |
| --- | --- |
| Push a `feature/**` | Ejecuta pruebas y análisis; construye si se aprueba el Quality Gate; omite el despliegue en Render |
| Pull request hacia `main` | Ejecuta pruebas y análisis; construye si se aprueba el Quality Gate; omite el despliegue |
| Push a `main` | Solicita el despliegue únicamente después de que `tests`, `sonar` y `build` terminen correctamente |
| Ejecución manual | Ejecuta pruebas y análisis; construye si se aprueba el Quality Gate; omite el despliegue |

El Deploy Hook solicita el despliegue, pero GitHub Actions no espera a que Render termine la construcción y el arranque. El job `deploy` y el Deploy Hook ya fueron validados en `main` antes de incorporar SonarQube Cloud al pipeline.

## Análisis de calidad con SonarQube Cloud

Proyecto propio: [Camii1234_lab2p2026](https://sonarcloud.io/project/overview?id=Camii1234_lab2p2026), perteneciente a la organización `camii1234`. La autenticación utiliza `SONAR_TOKEN`, configurado como secreto del repositorio de GitHub; su valor no se incluye en archivos ni se imprime.

El análisis importa el reporte XML generado por JaCoCo en `target/site/jacoco/jacoco.xml`, detectado automáticamente por SonarScanner. Los siguientes resultados fueron obtenidos y validados en `feature/sonarcloud`; las métricas locales de JaCoCo se conservan en su sección correspondiente.

| Indicador | Resultado |
| --- | --- |
| Quality Gate | Passed |
| Cobertura | 93,0 % |
| Seguridad | Calificación A; 0 problemas abiertos |
| Fiabilidad | Calificación A; 0 problemas abiertos |
| Mantenibilidad | Calificación A; 0 problemas abiertos |
| Duplicación | 0,0 % |
| Security Hotspots | 0 |

SonarQube Cloud también mostró 19 riesgos de dependencias con calificación D. Este resultado no impidió aprobar el Quality Gate y debe revisarse por separado para evaluar su alcance y aplicabilidad; no significa que todos los riesgos sean vulnerabilidades explotables.

## Análisis de seguridad con Snyk

El repositorio fue integrado con Snyk para analizar las dependencias declaradas en `pom.xml` y el contenedor definido mediante el `Dockerfile`.

| Análisis | Resultados revisados |
| --- | --- |
| Maven inicial (proyecto autenticado, `pom.xml`) | 44 dependencias y 24 hallazgos sin corrección soportada |
| Reporte público consultado durante la auditoría final | 43 dependencias y 16 vulnerabilidades mediante 36 rutas |
| Contenedor (`Dockerfile`) | Vulnerabilidades de paquetes del sistema operativo |

Los resultados fueron revisados y se conservarán para seguimiento. La diferencia entre el análisis inicial autenticado y el reporte público puede corresponder al alcance, la fuente o el momento del análisis; no debe presentarse como evidencia de que las vulnerabilidades hayan sido corregidas.

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

## Despliegue en Render

| Configuración | Valor |
| --- | --- |
| Servicio público | [lab2p2026-maria-camila.onrender.com](https://lab2p2026-maria-camila.onrender.com) |
| Plataforma | Render |
| Plan | Free |
| Región | Oregon |
| Construcción | Dockerfile del repositorio [Camii1234/lab2p2026](https://github.com/Camii1234/lab2p2026) |
| Auto-Deploy | Desactivado |

La integración sigue el flujo **GitHub Actions → Deploy Hook → Render → Docker**. Después de superar las pruebas y el Quality Gate y completar la construcción, el job `deploy` solicita a Render un despliegue en un push a `main` mediante el secreto `RENDER_DEPLOY_HOOK_URL`. Render construye la imagen con el Dockerfile del repositorio y ejecuta el JAR generado durante esa construcción.

La aplicación utiliza el `PORT` proporcionado por Render, con 8080 como valor predeterminado local. El contenedor mantiene Java 17 y el usuario sin privilegios `app`. Auto-Deploy está desactivado para que las solicitudes automáticas de despliegue se controlen desde el pipeline.

Los servicios del plan Free pueden entrar en reposo después de un periodo de inactividad. La primera solicitud posterior puede tardar más mientras el servicio vuelve a arrancar, según la [documentación oficial de Render](https://render.com/docs/free#spinning-down-on-idle).

La validación en la nube obtuvo:

| Endpoint público | HTTP | Resultado principal |
| --- | --- | --- |
| [GET /](https://lab2p2026-maria-camila.onrender.com/) | 200 | `HEALTH CHECK OK!` |
| [GET /version](https://lab2p2026-maria-camila.onrender.com/version) | 200 | `The actual version is 1.0.0` |
| [GET /nations](https://lab2p2026-maria-camila.onrender.com/nations) | 200 | 10 elementos |
| [GET /currencies](https://lab2p2026-maria-camila.onrender.com/currencies) | 200 | 20 elementos |
| [GET /aviation](https://lab2p2026-maria-camila.onrender.com/aviation) | 200 | 20 elementos |

## Estrategia de ramas

- **`main`:** rama estable del proyecto.
- **`feature/lab2-cicd`:** rama de trabajo para el pipeline, la contenerización y la documentación del laboratorio.
- **`feature/cloud-deployment`:** rama de trabajo para la integración y documentación del despliegue en Render.
- **`feature/sonarcloud`:** rama de trabajo para la integración y documentación del análisis de calidad con SonarQube Cloud.
- **Integración:** las ramas de trabajo se integran en `main` mediante un pull request, después de su revisión y de la ejecución exitosa de CI.

## Resultados verificados y estado

| Validación | Resultado |
| --- | --- |
| Pruebas con Java 17 | 7 exitosas, 0 fallos, 0 errores y 0 omitidas |
| `clean verify` | `BUILD SUCCESS` |
| JAR | `target/lab2p2026.jar` generado y ejecutable |
| Docker | Imagen `lab2p2026:local` construida correctamente |
| Backend en contenedor | Cinco endpoints con HTTP 200 y cantidades 10, 20 y 20 |
| Puerto y usuario del contenedor | `PORT=10000`, proceso Java como `app` con UID 10001 |
| CI de pruebas y construcción | Ejecución finalizada correctamente en `feature/lab2-cicd` |
| Render | Backend público desplegado con plan Free en Oregon |
| Backend en la nube | Cinco endpoints con HTTP 200 y cantidades 10, 20 y 20 |
| Integración de despliegue | Job `deploy` y Deploy Hook validados en `main` antes de incorporar SonarQube Cloud |

Las ejecuciones históricas exitosas pueden consultarse en GitHub Actions: [pruebas y construcción en `feature/lab2-cicd`](https://github.com/Camii1234/lab2p2026/actions/runs/37786740796) y [pruebas, construcción y despliegue en `main`](https://github.com/Camii1234/lab2p2026/actions/runs/37796502460).

La validación local, Docker, CI, la integración del despliegue y los endpoints del servicio en Render están completados. SonarQube Cloud está integrado y su análisis fue validado en `feature/sonarcloud` con los resultados documentados anteriormente. El pipeline de `main` fue validado exitosamente: se ejecutaron las pruebas (`tests`), el análisis SonarCloud (`sonar`) con Quality Gate aprobado, la construcción del JAR (`build`) y el despliegue en Render (`deploy`). La publicación de imágenes permanece fuera de esta etapa.

## Autoría y uso académico

Trabajo de **Maria Camila Castañeda Piedrahita**, elaborado para el Laboratorio 2 de Arquitectura de Software de la Universidad de Antioquia, periodo 2026-2, a partir del proyecto base entregado por el profesor Diego Botia.

El repositorio se presenta para uso académico. Actualmente no incluye un archivo de licencia independiente; esta documentación no atribuye una licencia de software que no haya sido definida.
