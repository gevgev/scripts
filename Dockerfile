FROM       ubuntu
MAINTAINER Gevorg Gevorgyan <gevgev@yahoo.com>

#ENV AWS_ACCESS_KEY_ID
#ENV AWS_SECRET_ACCESS_KEY

ADD ./run-ftp-s3.sh
ADD csbufferanalizer

ARG PATH
ARG FILE
ARG BUCKET

RUN ./run-ftp-s3.sh $PATH $FILE $BUCKET