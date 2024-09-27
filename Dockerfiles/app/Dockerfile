FROM openjdk:11 as build_image
RUN apt update && apt install maven -y
RUN git clone https://github.com/Uday-mac/vprofile-main.git
RUN cd vprofile-main && mvn install

From tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_image vprofile-main/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD [ "catalina.sh", "run" ] 