FROM java:8-alpine
LABEL author="Cody Oss"

EXPOSE 81 1522
ENV DOWNLOAD_FROM http://www.h2database.com/h2-2018-03-18.zip
ENV BASE_DIR /opt/h2-data
ENV TCP_PORT 1522

RUN apk add --no-cache curl \
    && curl ${DOWNLOAD_FROM} -o h2.zip \
    && mkdir -p /opt/h2-data \
    && unzip h2.zip -d /opt/ \
    && rm h2.zip \
    && apk del curl

CMD java -cp /opt/h2/bin/h2*.jar org.h2.tools.Server \
    -web -webAllowOthers -webPort 81 \
    -tcp -tcpAllowOthers -tcpPort ${TCP_PORT} \
    -baseDir ${BASE_DIR}
