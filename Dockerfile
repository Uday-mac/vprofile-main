FROM openjdk:8 AS BUILD_IMAGE
RUN apt-get update && apt-get install maven -y
RUN git clone -b docker-ecr https://github.com/Uday-mac/vprofile-main.git
RUN cd vprofile-main && mvn install

FROM tomcat:8-jre11
RUN rm -rf /usr/local/tomcat8/webapps/*
COPY --from=BUILD_IMAGE vprofile-main/target/vprofile-v2.war /usr/local/tomcat8/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]


