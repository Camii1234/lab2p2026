[![CI/CD Pipeline](https://github.com/diegobotia/lab2p2026/actions/workflows/build.yml/badge.svg)](https://github.com/diegobotia/lab2p2026/actions/workflows/build.yml)
[![Quality gate status](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=coverage)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=duplicated_lines_density)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Lines of Code](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=ncloc)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Reliability Rating](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=reliability_rating)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Maintainability issues](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=software_quality_maintainability_issues)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=security_rating)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=sqale_index)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=diegobotia_lab2p2026&metric=sqale_rating)](https://sonarcloud.io/summary/new_code?id=diegobotia_lab2p2026)

# lab2p2026

Implementation of a Simple App with the next operations:

* Get random nations
* Get random currencies
* Get random Aircraft
* Get application version
* health check

Including integration with GitHub Actions, Sonarqube (SonarCloud), Coveralls and Snyk

### Folders Structure

In the folder `src` is located the main code of the app

In the folder `test` is located the unit tests

### How to install it

Execute:

```shell
$ mvnw spring-boot:run
```
to download the node dependencies

### How to test it

Execute:

```shell
$ mvnw clean install
```

### How to get coverage test

Execute:

```shell
$ mvwn -B package -DskipTests --file pom.xml
```


