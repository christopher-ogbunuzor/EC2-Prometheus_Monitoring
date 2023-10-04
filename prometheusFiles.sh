cat <<EOF > prometheus.yml
global:
  scrape_interval: 15s
  external_labels:
    monitor: 'prometheus'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: node
    ec2_sd_configs:
      # Discover instances in the same account
      - port: 9100
        region: us-west-2
        profile: '${INSTANCE_PROFILE_ARN}'
      # # Discover instances in account 111111111111
      # - port: 9100
      #   role_arn: arn:aws:iam::111111111111:role/prometheus-assume-role-PrometheusAssumeRole-KJ4TK9KJBPU7 (note this is the ARN of the role created in the other account, yours may be different especially if you do not use CloudFormation)
      # # Continue as many entries as you have other accounts/regions
      # - port:9100
      #   role_arn: arn:aws:iam::222222222222:role/prometheus-assume-role-PrometheusAssumeRole-KJ4TK9KJBPU7
      #   region: us-west-2
EOF


cat <<EOF > prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target
EOF
sudo cp prometheus.yml /etc/prometheus/
sudo cp prometheus.service /etc/systemd/system/prometheus.service
