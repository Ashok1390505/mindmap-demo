# ----------- Stage 1: Build the application -------------
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies first for caching
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# ----------- Stage 2: Create a lightweight runtime image -------------
FROM eclipse-temurin:17-jre-alpine

# Add a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set the working directory
WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/myapp-0.0.1-SNAPSHOT.jar ./demo.jar

# Set environment variables
ENV JAVA_OPTS="-XX:+UseContainerSupport"

# Expose port
EXPOSE 8080

# Set permissions and switch to non-root user
RUN chown -R appuser:appgroup /app
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD wget --spider http://localhost:8080/actuator/health || exit 1

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar demo.jar"]
