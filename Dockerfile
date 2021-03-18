FROM jenkins/jenkins

ENV JENKINS_HOME="/data/jenkins"

USER root

RUN wget https://archive.apache.org/dist/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz \
    && tar zxvf apache-maven-3.6.2-bin.tar.gz \
    && mv apache-maven-3.6.2 /usr/local/maven \
    && rm -f apache-maven-3.6.2-bin.tar.gz \
    && wget https://npm.taobao.org/mirrors/node/v12.13.1/node-v12.13.1-linux-x64.tar.xz \
    && tar xf node-v12.13.1-linux-x64.tar.xz \
    && mv node-v12.13.1-linux-x64 /usr/local/nodejs \
    && rm -f node-v12.13.1-linux-x64.tar.xz \
    && echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

COPY docker /usr/bin/docker
COPY settings.xml /usr/local/maven/conf/

ENV NODE_HOME="/usr/local/nodejs"
ENV MAVEN_HOME="/usr/local/maven"
ENV PATH=${PATH}:${NODE_HOME}/bin:$MAVEN_HOME/bin

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
