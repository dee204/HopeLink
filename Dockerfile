FROM tomcat:9.0-jdk11-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY dist/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 3000

CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-3000}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]