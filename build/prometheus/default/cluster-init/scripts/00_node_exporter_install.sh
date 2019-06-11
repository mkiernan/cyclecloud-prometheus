#!/bin/bash -x

# Install Prometheus Node Exporter: https://prometheus.io/docs/guides/node-exporter/
#yum groupinstall "Development Tools"
#wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz
#export PATH=$PATH:/usr/local/go/bin
#go get github.com/prometheus/node_exporter
#cd src/github.com/prometheus/node_exporter
#make

useradd --home-dir /home/prometheus --shell /bin/false prometheus

cd /home/prometheus
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xvf node_exporter-0.18.1.linux-amd64.tar.gz
cd node_exporter-0.18.1.linux-amd64/
cp ./node_exporter /home/prometheus

cat << EOF >> /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=prometheus
ExecStart=/home/prometheus/node_exporter

[Install]
WantedBy=default.target
EOF

systemctl daemon-reload
systemctl enable node_exporter.service
systemctl start node_exporter.service
systemctl status node_exporter.service
