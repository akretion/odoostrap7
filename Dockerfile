FROM ubuntu:trusty
MAINTAINER rvalyi "rvalyi@akretion.com"

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y git && \
    apt-get clean

RUN DEBIAN_FRONTEND=noninteractive && \
    mkdir -p /opt/odoostrap/parts

#sha1
#3632949cffb24180832e18a3f19a6d02bd8e8729
RUN cd /opt/odoostrap/parts && git clone https://github.com/odoo/odoo.git -b 7.0 --depth=50
RUN cd /opt/odoostrap/parts/odoo && \
    git remote add ocb https://github.com/OCA/OCB.git && \
    git fetch ocb 7.0 --depth=50

# seems this won't free any space sadly
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get remove -y --purge git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/*.deb
