FROM python:3.11-bookworm

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-arm64
ENV SPARK_HOME=/home/spark
ENV PATH=$SPARK_HOME/bin:$PATH

RUN apt-get update && apt-get install -y openjdk-17-jre-headless curl wget vim sudo whois ca-certificates-java \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O apache-spark.tgz "https://dlcdn.apache.org/spark/spark-3.5.7/spark-3.5.7-bin-hadoop3.tgz" \
    && mkdir -p /home/spark \
    && tar -xf apache-spark.tgz -C /home/spark --strip-components=1 \
    && rm apache-spark.tgz

ARG USERNAME=sparkuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN chown -R $USER_UID:$USER_GID ${SPARK_HOME}

RUN mkdir -p ${SPARK_HOME}/logs \
    && mkdir -p ${SPARK_HOME}/event_logs \
    && chown -R $USER_UID:$USER_GID ${SPARK_HOME}/event_logs \
    && chown -R $USER_UID:$USER_GID ${SPARK_HOME}/logs

RUN echo "spark.eventLog.enabled true" >> $SPARK_HOME/conf/spark-defaults.conf \
    && echo "spark.eventLog.dir file://${SPARK_HOME}/event_logs" >> $SPARK_HOME/conf/spark-defaults.conf \
    && echo "spark.history.fs.logDirectory file://${SPARK_HOME}/event_logs" >> $SPARK_HOME/conf/spark-defaults.conf

RUN pip install --no-cache-dir jupyter findspark

COPY entrypoint.sh /home/spark/entrypoint.sh
RUN chmod +x /home/spark/entrypoint.sh

USER $USERNAME

RUN mkdir -p /home/$USERNAME/app

WORKDIR /home/$USERNAME/app

EXPOSE 4040 4041 18080 8888

ENTRYPOINT ["/home/spark/entrypoint.sh"]
