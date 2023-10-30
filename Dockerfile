FROM ubuntu:20.04
ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.82
RUN apt update -y
RUN apt install openjdk-11-jdk -y
RUN mkdir -p /u01/middleware

WORKDIR /u01/middleware
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.82/bin/apache-tomcat-9.0.82.tar.gz .
RUN tar -xzvf apache-tomcat-9.0.82.tar.gz
RUN rm -rf apache-tomcat-9.0.82.tar.gz
COPY target/foodies.war ${TOMCAT_HOME}/webapps/

COPY run.sh .
RUN chmod u+x run.sh

ENTRYPOINT ["./run.sh"]
CMD [ "tail -f /dev/null" ]
