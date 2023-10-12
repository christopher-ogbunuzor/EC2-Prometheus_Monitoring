## future Work
- use private ip for ec2 in prometheus.yml
- lock down using my own vpc
- view metrics for ec2 and plot in grafana
- get grafana dashboard to work


## useful commands
`tree`

`terraform validate`

`terraform fmt`

`terraform plan`

`terraform apply --auto-approve`

`terraform destroy`

`aws ec2 describe-instances --region us-east-1`

`aws ec2 describe-vpcs`

`aws ec2 describe-instances --region us-east-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value, PublicIpAddress, PrivateIpAddress]' --output json | jq -r '.[][] | @tsv'`

`aws ec2 describe-instances --region us-east-1 --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value, PublicIpAddress, PrivateIpAddress]' --output json`

`ssh -i /path/to/your/private-key.pem ec2-user@ec2-instance-public-ip`



[full_tutorial](https://devops4solutions.com/monitoring-using-prometheus-and-grafana-on-aws-ec2/)

Download prometheus [here](https://www.cherryservers.com/blog/install-prometheus-ubuntu)

Download grafana [here](https://computingforgeeks.com/how-to-install-grafana-on-ubuntu-linux-2/)

Download nodeexporter [here](https://prometheus.io/download/#node_exporter/) [here2](https://ourcodeworld.com/articles/read/1686/how-to-install-prometheus-node-exporter-on-ubuntu-2004)

Download nginx [here](https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04) [here2](https://antonputra.com/monitoring/monitor-nginx-with-prometheus/#expose-basic-nginx-metrics)
