
FROM eclipse-temurin:21-jdk AS build
WORKDIR /app

COPY . .
RUN chmod +x ./mvnw && ./mvnw -DskipTests package


FROM eclipse-temurin:21-jre
WORKDIR /app


RUN groupadd -r app && useradd -r -g app app


COPY --from=build /app/target/*.jar /app/app.jar
RUN chown -R app:app /app


USER app

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]