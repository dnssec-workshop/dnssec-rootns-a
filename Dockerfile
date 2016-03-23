# Image: dnssec-rootns-a
# Startup a docker container as BIND master for DNS root zone

FROM dnssecworkshop/dnssec-bind

MAINTAINER dape16 "dockerhub@arminpech.de"

# Set timezone
ENV     TZ=Europe/Berlin
RUN     ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Deploy DNSSEC workshop material
RUN     cd /root && git clone https://github.com/dnssec-workshop/dnssec-data && rsync -v -rptgoD --copy-links /root/dnssec-data/dnssec-rootns-a/ /

# Start services using supervisor
RUN     mkdir -p /var/log/supervisor

EXPOSE  22 53
CMD     [ "/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/dnssec-rootns-a.conf" ]

# vim: set syntax=docker tabstop=2 expandtab:
