data "aws_ami" "amazon_ec2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

   filter {
     name    = "virtualization-type"
     values  = ["hvm"]
   }

   owners = ["099720109477"] 
}


resource "aws_instance" "app" {
  count				= length(var.sub_pub)
  ami				= data.aws_ami.amazon_ec2.image_id 
  instance_type			= var.type
  subnet_id			= var.sub_pub[count.index]
  vpc_security_group_ids	= [var.app_sg_id]
  monitoring 			= true 
  associate_public_ip_address 	= true
  key_name                    	= var.key-pair

  root_block_device {
    volume_size = 20 
  }
  tags = {
    Name = "instance-${count.index}"
  }
}


