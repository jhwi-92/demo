################ Build stage ################
FROM gradle:8.5-jdk21 AS build
ARG ENVIROMENT=alpha
ARG MODULE_NAME=default

#Work Directory
WORKDIR /app

# Copy Gradle files
# COPY settings.gradle .
# COPY build.gradle .

# Copy the main project code
# COPY message-api/ ./message-api
# COPY message-batch/ ./message-batch
# COPY message-common/ ./message-common
# COPY message-domain/ ./message-domain


# Copy Gradle Wrapper
# COPY gradlew .
# COPY gradle/ ./gradle

# Gradle Wrapper 실행 권한 부여
# RUN chmod +x gradlew

# Build API JAR
# WORKDIR /app/message-api
# RUN ../gradlew clean build

# Build Batch JAR
# WORKDIR /app/message-batch
# RUN ../gradlew clean build

################ Production stage ################
# FROM eclipse-temurin:21
# ARG MODULE_NAME
# ARG SPRING_PROFILES_ACTIVE
# ENV SPRING_PROFILES_ACTIVE $SPRING_PROFILES_ACTIVE
# ENV MODULE_NAME $MODULE_NAME

# WORKDIR /app

#추후 스크립트를 이용해서 각각 컨테이너마다 api or batch 나눠서 복사할 것
# Copy JAR files from build stage
# COPY --from=build /app/message-api/build/libs/*.jar /app/api.jar
# COPY --from=build /app/message-batch/build/libs/*.jar /app/batch.jar

# Run both JAR files in the background
#CMD ["java", "-jar", "/app/api.jar"] && ["java", "-jar", "/app/batch.jar"]
#CMD ["sh", "-c", "java -Xmx512m -Xms512m -XX:+UseZGC -jar /app/api.jar & java -Xmx512m -Xms512m -XX:+UseZGC -jar /app/batch.jar"]
# CMD ["sh", "-c", "java -Xmx512m -Xms512m -XX:+UseZGC -jar /app/api.jar & java -Xmx512m -Xms512m -XX:+UseZGC -jar /app/batch.jar & tail -f /dev/null"]
# CMD ["/bin/bash", "-c", "if [ \"$MODULE_NAME\" = \"api\" ]; then java -Dspring.profiles.active=$SPRING_PROFILES_ACTIVE -Xmx512m -Xms512m -XX:+UseZGC -jar /app/api.jar & tail -f /dev/null; elif [ \"$MODULE_NAME\" = \"batch\" ]; then java -Dspring.profiles.active=$SPRING_PROFILES_ACTIVE -Xmx512m -Xms512m -XX:+UseZGC -jar /app/batch.jar & tail -f /dev/null; fi"]