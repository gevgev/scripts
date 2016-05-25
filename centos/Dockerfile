FROM       centos
MAINTAINER Gevorg Gevorgyan <gevgev@yahoo.com>

#ENV AWS_ACCESS_KEY_ID
#ENV AWS_SECRET_ACCESS_KEY

# zip unzip
# python
# aws 
# RUN yum install -y wget

RUN yum install -y python

RUN yum install -y unzip

RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

ADD csbufferanalizer csbufferanalizer
ADD run-ftp-s3.sh run-ftp-s3.sh

ENTRYPOINT ./run-ftp-s3.sh
