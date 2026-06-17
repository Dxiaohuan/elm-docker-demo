# 第一阶段：Maven 构建
  FROM maven:3.8-openjdk-8 AS builder
  WORKDIR /app
  COPY pom.xml .
  RUN mvn dependency:go-offline -B
  COPY src ./src
  RUN mvn clean package -DskipTests

  # 第二阶段：运行镜像
  FROM openjdk:8-jre-alpine
  WORKDIR /app
  COPY --from=builder /app/target/elm-boot-1.0.0.jar app.jar
  EXPOSE 8081
  ENTRYPOINT ["java", "-jar", "app.jar"]
