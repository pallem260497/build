FROM alpine
LABEL MAINTAINER pallem260497@gmail.com
COPY target/webapp.war /usr/tomcat/webapps/
EXPOSE 8082
CMD ["catalina.sh" "run"]
