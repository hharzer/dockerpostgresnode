FROM ubuntu:20.04

ARG PG_USER=userdmi
ARG PG_PWD=123456
ARG PG_DBNAME=db1

RUN apt-get update

RUN apt-get install -y gnupg2

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" > /etc/apt/sources.list.d/pgdg.list

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Europe/Moscow

RUN apt-get install -y tzdata

RUN apt-get install -y postgresql-12 postgresql-client-12 postgresql-contrib-12

USER postgres

RUN /etc/init.d/postgresql start &&\
	psql --command "CREATE USER ${PG_USER} WITH SUPERUSER PASSWORD '${PG_PWD}';" &&\
	createdb -O ${PG_USER} ${PG_DBNAME}

RUN echo "host	all	all	0.0.0.0/0	md5" >> /etc/postgresql/12/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

EXPOSE 5432

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/12/bin/postgres", "-D", "/var/lib/postgresql/12/main", "-c", "config_file=/etc/postgresql/12/main/postgresql.conf"] 

