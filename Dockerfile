FROM tomcat:9.0
COPY deployments/latest.war /usr/local/tomcat/webapps/app.war
VOLUME ["/opt/saip/logs"]
