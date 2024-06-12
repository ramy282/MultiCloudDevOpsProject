resource "aws_internet_gateway" "igw" {
  vpc_id = var.iVolve

  tags = {
    Name = var.internet-gateway
  }
}
