FROM ubuntu:22.04

SHELL ["/bin/bash", "-c"]

# install dependencies of opensourcecobol 4J and Open COBOL ESQL 4J
RUN apt-get update &&\
    apt-get install -y default-jdk build-essential bison flex gettext texinfo libgmp-dev autoconf git unzip zip &&\
    curl -s "https://get.sdkman.io" | bash &&\
    source "/root/.sdkman/bin/sdkman-init.sh" &&\
    sdk install sbt

ENV CLASSPATH :/usr/lib/opensourcecobol4j/sqlite.jar:/usr/lib/opensourcecobol4j/libcobj.jar:/usr/lib/opensourcecobol4j/ocesql4j.jar:/usr/lib/opensourcecobol4j/postgresql.jar

# install SQLite JDBC driver
RUN mkdir /usr/lib/opensourcecobol4j &&\
    curl -L -o /usr/lib/opensourcecobol4j/sqlite.jar -k https://github.com/xerial/sqlite-jdbc/releases/download/3.36.0.3/sqlite-jdbc-3.36.0.3.jar &&\
    curl -L -o /usr/lib/opensourcecobol4j/postgresql.jar -k https://jdbc.postgresql.org/download/postgresql-42.2.24.jre6.jar

# install opensourcecobol4j
RUN cd /root &&\
    git clone https://github.com/opensourcecobol/opensourcecobol4j.git &&\
    cd opensourcecobol4j &&\
    ./configure --prefix=/usr/ &&\
    make &&\
    make install

# install Open COBOL ESQL 4J
RUN cd /root &&\
    source "/root/.sdkman/bin/sdkman-init.sh" &&\
    git clone https://github.com/opensourcecobol/Open-COBOL-ESQL-4j.git &&\
    cd Open-COBOL-ESQL-4j &&\
    ./configure --prefix=/usr/ &&\
    make &&\
    make install &&\
    cd dblibj &&\
    cp /usr/lib/opensourcecobol4j/{postgresql,libcobj}.jar lib &&\
    sbt assembly &&\
    cp target/scala-2.13/ocesql4j.jar /usr/lib/opensourcecobol4j/

# classpath settings
RUN echo 'export CLASSPATH=:/usr/lib/opensourcecobol4j/sqlite.jar:/usr/lib/opensourcecobol4j/libcobj.jar:/usr/lib/opensourcecobol4j/ocesql4j.jar:/usr/lib/opensourcecobol4j/postgresql.jar' >> ~/.bashrc

WORKDIR /root/

CMD ["/bin/bash"]
