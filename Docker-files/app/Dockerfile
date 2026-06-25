FROM maven:3.9.9-eclipse-temurin-21-jammy AS base
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:10-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=base /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]