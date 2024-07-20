resource "aws_key_pair" "main" {
  key_name   = "ta-lab-key"
  public_key = file("id_rsa.pub")
}