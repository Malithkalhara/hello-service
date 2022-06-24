###################################################################################################3
## builder stage
###################################################################################################3
FROM    maven:3-jdk-11-slim AS builder
COPY    src /home/app/src
COPY    pom.xml /home/app
RUN     mvn -f /home/app/pom.xml clean package

###################################################################################################3
## built image
###################################################################################################3
FROM    registry.access.redhat.com/ubi8/openjdk-11
COPY    --from=builder /home/app/target/*.jar app.jar
EXPOSE  8080
ENTRYPOINT ["java", "-jar", "app.jar"]