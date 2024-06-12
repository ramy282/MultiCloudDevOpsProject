resource "aws_subnet" "public" {
  for_each          = var.public_subnet
  vpc_id            = var.iVolve
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
    Name = each.value.name
  }
}
