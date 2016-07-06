FROM mongo:latest
MAINTAINER Marcos Sanz <marcos.sanz@13genius.com>

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD set_mongodb_password.sh /set_mongodb_password.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]

