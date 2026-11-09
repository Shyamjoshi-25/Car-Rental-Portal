FROM maven:3.9.11-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY WebContent ./WebContent
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/target/CarRentalPortal.war /usr/local/tomcat/webapps/ROOT.war
COPY docker/entrypoint.sh /usr/local/bin/car-rental-entrypoint.sh
RUN chmod +x /usr/local/bin/car-rental-entrypoint.sh \
    && sed -i 's#</Service>#<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol" maxThreads="150" SSLEnabled="true" scheme="https" secure="true" defaultSSLHostConfigName="_default_">\n        <SSLHostConfig hostName="_default_" protocols="TLSv1.2,TLSv1.3">\n          <Certificate certificateKeystoreFile="/usr/local/tomcat/conf/carrental-demo.p12" certificateKeystoreType="PKCS12" certificateKeystorePassword="__KEYSTORE_PASSWORD__" />\n        </SSLHostConfig>\n      </Connector>\n</Service>#' /usr/local/tomcat/conf/server.xml
EXPOSE 8080 8443
ENTRYPOINT ["/usr/local/bin/car-rental-entrypoint.sh"]
