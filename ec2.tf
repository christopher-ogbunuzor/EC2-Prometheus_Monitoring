resource "aws_instance" "prometheus" {
  ami             = "ami-0735c191cf914754d"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "ta-lab-key"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  
  user_data = base64encode(join("", [
    file("${path.module}/prometheusInstall.sh"),
    file("${path.module}/prometheusFiles.sh"),
    file("${path.module}/prometheusRestart.sh"),
    file("${path.module}/grafanaInstall.sh"),
  ]))
  
  tags = {
    Name = "prometheus"
  }
} 

# resource "aws_instance" "web2" {
#   ami             = "ami-0735c191cf914754d"
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.TF_SG.name]
#   key_name = "ta-lab-key"

#   tags = {
#     Name = "grafana"
#   }

#   user_data = filebase64("${path.module}/grafanaInstall.sh")

# }

resource "aws_instance" "node1" {
  ami             = "ami-0735c191cf914754d"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.TF_SG.name]
  key_name = "ta-lab-key"
  user_data = filebase64("${path.module}/nodeexporterInstall.sh")

  tags = {
    Name = "node1"
  }
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

