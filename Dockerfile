FROM       ubuntu
MAINTAINER Gevorg Gevorgyan <gevgev@yahoo.com>

#ENV AWS_ACCESS_KEY_ID
#ENV AWS_SECRET_ACCESS_KEY
RUN apt-get update \
  && apt-get upgrade -y 

RUN apt-get install -y wget \
  && apt-get install -y zip unzip 

RUN apt-get install -y \
    ssh \
    python \
    python-pip \
    python-virtualenv

RUN \
    mkdir aws && \
    virtualenv aws/env && \
    ./aws/env/bin/pip install awscli && \
    echo 'source $HOME/aws/env/bin/activate' >> .bashrc && \
    echo 'complete -C aws_completer aws' >> .bashrc

RUN export PATH=/home/aws/aws/env/bin:$PATH 

USER root
ADD csbufferanalizer csbufferanalizer
ADD run-ftp-s3.sh run-ftp-s3.sh

ARG FTPPATH
ARG FILE
ARG BUCKET

ENTRYPOINT ./run-ftp-s3.sh $FTPPATH $FILE $BUCKET
