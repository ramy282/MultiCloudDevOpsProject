resource "aws_route_table" "public_route_table" {
  vpc_id = var.iVolve

  route {
    cidr_block = var.route-cidr
    gateway_id = var.igw
  }

  tags = {
    Name = var.tag
  }
}

resource "aws_route_table_association" "route_table_ass" {
  count          = length(var.sub_pub)
  subnet_id      = var.sub_pub[count.index]
  route_table_id = aws_route_table.public_route_table.id
}
