FROM tomcat:8-jre11
RUN apt update && apt install maven -y
RUN mvn install 
RUN rm -rf /usr/local/tomcat/webapps/*
COPY vprofile-main/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war 
EXPOSE 8080
CMD [ "catalina.sh", "run" ]