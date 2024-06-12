variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "iVolve"
}

variable "public_subnet" {
  description = "Public Subnet"

  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
}

# variable "sg-cidr" {
 # description = "cidar of SG"
 # type        = list(string)
 # default     = ["0.0.0.0/0"]
#}

variable "internet-gateway" {
  description = "name of IGW"
  type        = string
  default     = "iVolve-IGW"
}

variable "route-cidr" {
  description = "cidr-block of Route Table"
  type        = string
  default     = "0.0.0.0/0"
}
variable "tag" {
  type        = string
  default     = "Public-route-table"
}

variable "type-ec2" {
  description = "size of EC2"
  type        = string
  default     = "t2.large"
}

variable "key-pair" {
  description = "key pair of ec2"
  type        = string
  default     = "iVolve-key"
}

variable "Email" {
  description = "Email For SNS Topic Subscription "
  type        = string
  default     = "ramyanwar282@gmail.com"
}

variable "time" {
  description = "Time of CloudWatch Alarm "
  type        = string
  default     = "300"
}

variable "bucket_name" {
  description = "Name Of S3 Bucket "
  type        = string
  default     = "ivolve-bucket"
}

variable "bucket_region" {
  description = "Region Of S3 Bucket "
  type        = string
  default     = "us-west-1"
}

