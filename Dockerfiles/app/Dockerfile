FROM openjdk:11 AS build_image
RUN apt update && apt install maven -y
RUN git clone -b docker https://github.com/Uday-mac/vprofile-main.git
RUN cd vprofile-main && mvn install

FROM tomcat:9-jre11
LABEL "Author"="uday"
LABEL "project"="vprofile"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_image vprofile-main/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
CMD [ "catalina.sh", "run" ] 