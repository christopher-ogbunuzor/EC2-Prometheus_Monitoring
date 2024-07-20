## future Work
- [ ] use private ip for ec2 in prometheus.yml
- [x] lock down using my own vpc
- [x] view metrics for ec2 and plot in grafana
- [x] get grafana dashboard to work


## Verify stuffs are working
prometheus and grafana are deployed on same EC2 while the other EC2 is used to deploy node exporter
To view prometheus, `http://IP_prometheusEC2:9090`
To view grafana, `http://IP_prometheusEC2:3000` and put `http://IP_prometheusEC2:9090` in url when you create grafana prometheus datasource. Dont forget to set to `browser` mode from `server` mode. It should say `data source is working` when you click `save and test`. 

You can also connect to the prometheus server from another grafana instance entirely, you just need to open up port 3000 to it

## Some useful commands
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
