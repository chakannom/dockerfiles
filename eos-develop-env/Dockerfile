FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
      apt-get update; \
      apt-get install -y sudo git gdb clang-7 vim ;

# explicitly set user/group IDs
RUN set -eux; \
	groupadd -r eosio --gid=999; \
	useradd -r -g eosio --uid=999 --home-dir=/home/eosio --shell=/bin/bash eosio; \
	echo 'root:eosio' | chpasswd; \
	echo 'eosio:eosio' | chpasswd; \
	adduser eosio sudo; \
	mkdir -p /home/eosio; \
	chown -R eosio:eosio /home/eosio;
WORKDIR /home/eosio

RUN set -eux; \
      chown -R eosio:eosio /home/eosio; \
	  update-alternatives --install /usr/bin/clang clang /usr/bin/clang-7 1; \
	  update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-7 1;

COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh

USER eosio

ENTRYPOINT ["/docker-entrypoint.sh"]
