FROM nginx:stable-alpine

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u111
ENV JAVA_ALPINE_VERSION 8.111.14-r0

RUN set -x && apk add --no-cache openjdk8 && [ "$JAVA_HOME" = "$(docker-java-home)" ]

RUN apk add --no-cache bash graphviz

ADD open-sans.tar.gz /usr/share/fonts/

RUN adduser java -h / -D
RUN set -x
RUN apk add --no-cache curl unzip graphviz fontconfig
RUN fc-cache -fv

COPY ./drivers/pgsql_driver.jar /assets/
# COPY ./drivers/mysql_driver.jar /assets/
# COPY ./drivers/mariadb_driver.jar /assets/
# COPY ./drivers/jtds_driver.jar /assets/
COPY schemaspy.jar /assets/
COPY pgsql11.properties /assets/
COPY docker-entrypoint.sh /usr/local/bin/
# RUN ln -s /assets/pgsql_driver.jar /assets/pgsql11_driver.jar

RUN ln -s /usr/local/bin/docker-entrypoint.sh /

EXPOSE 80

ENTRYPOINT ["bash", "docker-entrypoint.sh"]