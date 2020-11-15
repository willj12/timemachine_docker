
# x86_64
FROM alpine

MAINTAINER willj12

# install packages
RUN \
 apk add --no-cache \
	samba \
	avahi

RUN rm -f /etc/avahi/services/*
COPY smb.conf /etc/smb/smb.conf
COPY samba.service /etc/avahi/services/samba.service

RUN sed -i 's/#enable-dbus=yes/enable-dbus=no/' /etc/avahi/avahi-daemon.conf

RUN adduser -D timemachine && echo -e '<password placeholder>' | smbpasswd -as timemachine
RUN mkdir /backups && chown -R timemachine /backups

RUN echo -e "#!/bin/sh\navahi-daemon -D && smbd -FS --configfile /etc/smb/smb.conf --no-process-group" > /run.sh && chmod 755 /run.sh

# default command
CMD ["/run.sh"]
