# resource "aws_instance" "web" {
#   ami           = "ami-053b0d53c279acc90" 
#   instance_type = "t2.micro"
#   count         = 3

#   tags = {
#     Name = element(["prometheus", "grafana", "nodeexplorer"], count.index)
#   }
# }

resource "aws_instance" "web1" {
  ami             = "ami-0735c191cf914754d"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "ta-lab-key"

  tags = {
    Name = "prometheus"
  }

  user_data = filebase64("${path.module}/prometheusInstall.sh")

}

resource "aws_instance" "web2" {
  ami             = "ami-0735c191cf914754d"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "ta-lab-key"

  tags = {
    Name = "grafana"
  }

  user_data = filebase64("${path.module}/grafanaInstall.sh")

}

# resource "aws_instance" "web3" {
#   ami             = "ami-053b0d53c279acc90"
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.TF_SG.name]
#   key_name = "devopsKP"

#   tags = {
#     Name = "nodeexporter"
#   }

#     user_data = base64encode(join("", [
#     file("${path.module}/nginxInstall.sh"),
#     file("${path.module}/nodeexporterInstall.sh"),
#   ]))

# }

