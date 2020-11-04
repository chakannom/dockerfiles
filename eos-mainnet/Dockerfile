FROM ubuntu:18.04
MAINTAINER Seon Yu <genteelson@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

## for Postgresql
RUN set -eux; \
      apt-get update; \
      apt-get install -y wget sudo gnupg2 lsb-release vim; \
      wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -; \
      echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list; \
      apt-get update; \
      apt-get install -y postgresql-12 postgresql-client-12; \
      rm -rf /var/lib/apt/lists/*; \
      rm -rf /var/lib/postgresql;

ADD postgresql_12.tgz /var/lib

RUN set -eux; \
      locale-gen en_US.utf8; \
      chown -R postgres:postgres /var/lib/postgresql; \
      echo "host    all             all             0.0.0.0/0            md5" >> /etc/postgresql/12/main/pg_hba.conf; \
      echo "host    all             all             ::/0                 md5" >> /etc/postgresql/12/main/pg_hba.conf; \
      echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf;

## for Eos
RUN set -eux; \
      apt-get update; \
      apt-get install -y libatomic1 libssl1.0.0; \
      rm -rf /var/lib/apt/lists/*;

# explicitly set user/group IDs
RUN set -eux; \
	groupadd -r eosio --gid=999; \
	useradd -r -g eosio --uid=999 --home-dir=/home/eosio --shell=/bin/bash eosio; \
	mkdir -p /home/eosio; \
	chown -R eosio:eosio /home/eosio;
WORKDIR /home/eosio

ADD eos.tgz ./
COPY node ./node/
COPY history-tools ./history-tools/
RUN set -eux; \
      chmod -R 755 ./node/bin/*; \
      chmod -R 755 ./history-tools/bin/*; \
      chown -R eosio:eosio /home/eosio;

COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8888 8080 9876 5432
