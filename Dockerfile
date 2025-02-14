FROM centos:7
COPY entrypoint.sh /entrypoint.sh
RUN \
yum install epel-release -y; \
yum install vim less sudo jq gcc-c++ make -y git; \
yum install -y https://dl.grafana.com/oss/release/grafana-8.1.2-1.x86_64.rpm; \
service grafana-server start; \
grafana-cli plugins install simpod-json-datasource; \
service grafana-server restart; \
git clone https://github.com/riveraja/ptstalk-gui /opt/ptstalk-gui; \
yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm -y; \
percona-release enable psmdb-44; \
yum install percona-server-mongodb -y; \
curl -sL https://rpm.nodesource.com/setup_14.x | bash -; \
yum install nodejs  -y; \
cd /opt/ptstalk-gui; \
npm install; \
npm link; \
chmod +x /entrypoint.sh


WORKDIR /opt/ptstalk-gui

EXPOSE 3000 9000

CMD ["/entrypoint.sh"]
VOLUME ["/var/lib/pt-stalk"]

