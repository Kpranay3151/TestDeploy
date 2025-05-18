FROM tomcat:9.0
COPY deployments/AODB-SAIP-1.0.0.war /usr/local/tomcat/webapps/app.war
VOLUME ["/opt/saip/logs"]
