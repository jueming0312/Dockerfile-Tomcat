# create tomcat image
FROM 10.100.4.214:1180/jdk/jdk:1.8.0v1
MAINTAINER "wangenzhi <W_enzhi@163.com>"
ENV CATALINA_HOME="/usr/local/tomcat/"
ENV PATH=${CATALINA_HOME}/bin:${PATH}

RUN mkdir -p /data/{logs,backup/tomcat} && echo "Asia/shanghai" > /etc/timezone && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD apache-tomcat-8.5.15.tar.gz /usr/local/
COPY catalina.sh /usr/local/apache-tomcat-8.5.15/bin/
COPY server.xml /usr/local/apache-tomcat-8.5.15/conf/
RUN chmod +x /usr/local/apache-tomcat-8.5.15/bin/catalina.sh && ln -sv /usr/local/apache-tomcat-8.5.15/ /usr/local/tomcat && ln -sv /usr/local/tomcat/ /data/backup/tomcat/lastversion && ln -sv /usr/local/tomcat/logs/ /data/logs/tomcat && rm -fr /usr/local/apache-tomcat-8.5.15/webapps/*
COPY entrypoint.sh /usr/local/tomcat/bin/entrypoint.sh
RUN chmod 777 /usr/local/tomcat/bin/entrypoint.sh
EXPOSE 8080/tcp
ENTRYPOINT ["/bin/bash","/usr/local/tomcat/bin/entrypoint.sh"]
