resource "aws_instance" "prometheus" {
  ami             = "ami-0735c191cf914754d"
  instance_type   = "t2.micro"
  # security_groups = [aws_security_group.TF_SG.name] ## Works only on default vpc
  vpc_security_group_ids = [ aws_security_group.TF_SG.id ]
  key_name = aws_key_pair.main.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id = aws_subnet.example.id
  
  user_data = base64encode(join("", [
    file("${path.module}/Scripts/prometheusInstall.sh"),
    file("${path.module}/Scripts/prometheusFiles.sh"),
    file("${path.module}/Scripts/prometheusRestart.sh"),
    file("${path.module}/Scripts/grafanaInstall.sh"),
    file("${path.module}/Scripts/nodeexporterInstall.sh"),
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
  # security_groups = [aws_security_group.TF_SG.name] ## Works only on default vpc
  vpc_security_group_ids = [ aws_security_group.TF_SG.id ]
  subnet_id = aws_subnet.example.id
  key_name = aws_key_pair.main.key_name
  
  user_data = filebase64("${path.module}/Scripts/nodeexporterInstall.sh")

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

