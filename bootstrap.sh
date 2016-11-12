#!/usr/bin/env bash

add-apt-repository ppa:webupd8team/java

apt-get update

echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get install oracle-java8-installer -y


wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.0.0.deb 
dpkg -i elasticsearch-5.0.0.deb

echo "192.168.33.10 vagrant-es-server" >> /etc/hosts 
echo "192.168.33.1 vagrant-es-client" >> /etc/hosts

echo "network.host: vagrant-es-server" >> /etc/elasticsearch/elasticsearch.yml
echo "cluster.name: es-syslog-ng" >> /etc/elasticsearch/elasticsearch.yml

service elasticsearch start

