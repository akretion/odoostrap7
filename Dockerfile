FROM ubuntu:trusty
MAINTAINER rvalyi "rvalyi@akretion.com"

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y git wget python && \
    apt-get clean

RUN DEBIAN_FRONTEND=noninteractive && \
    mkdir -p /opt/odoostrap/parts

#sha1
#625aa7e75ddb4d943c1dac51909df31f7876ed28
RUN cd /opt/odoostrap/parts && git clone https://github.com/odoo/odoo.git -b 8.0 --depth=10

ADD buildout.cfg /opt/odoostrap/buildout.cfg

RUN cd /opt/odoostrap && \
    wget https://raw.github.com/buildout/buildout/master/bootstrap/bootstrap.py && \
    /usr/bin/python bootstrap.py && \
    /usr/bin/python bin/buildout && \
    rm buildout.cfg

# seems this won't free any space sadly
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get remove -y --purge git wget python && \
    apt-get autoremove -y && \
    apt-get clean
