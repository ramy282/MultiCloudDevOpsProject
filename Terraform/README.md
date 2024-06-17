# Infrastructure Provisioning with Terraform

## AWS Environment Setup
This Terraform modules configuration establishes an AWS environment that includes key components like VPC, Subnets, , EC2 Instance , Security Groups, Route Tables and Internet Gateway. And also include CloudWatch for monitoring and an S3 Bucket as backend state.

### Prerequisites:
- Before you start make sure you have:

 1- **AWS IAM User**
    - Make IAM with suitable permissions and Configure your AWS credentials on your machine 
   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/46157340-979f-4df0-9018-542301d4ac61)
    
   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/54b211df-ec87-47eb-abbb-0bd95e70b3c8)

 2- Create a Key-pair for the EC2 Instance in your region 
 
   ![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/291595bf-bc6b-4d8a-bb70-4236c02f7e6d)


### Configuration:

- The Structure of the Enviromrnt
```
.
├── main.tf
├── .terraform.lock.hcl
├── terraform.tfstate
├── terraform.tfstate.backup
├── values.auto.tfvars
├──  variables.tf
├── outputs.tf
├── modules
│   ├── CloudWatch
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── EC2
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── igw
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── routetable
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── s3
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── sg
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── subnet
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
        ├── main.tf
        ├── outputs.tf
        └── variables.tf

``` 
1. **VPC:**
   - Employs the ./vpc module to create a Virtual Private Cloud (VPC) with the designated CIDR block.

  - in /vpc module 
   ```
     resource "aws_vpc" "iVolve_vpc" {
     cidr_block = var.vpc_cidr
     tags = {
     Name = var.vpc_name
        }
      }
  ```
- in main.tf
```
    module "vpc"{
    source = "./modules/vpc"
    vpc_cidr       = var.vpc_cidr
    vpc_name       = var.vpc_name
     }
```

2. **Subnets**
   - Employs the ./subnet module to to create a subnet inside the (vpc)
  
- in /subnet module
```
  resource "aws_subnet" "public" {
  for_each          = var.public_subnet
  vpc_id            = var.iVolve
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = {
  Name = each.value.name
    }
   }
```
    
- in main.tf
```
    module "subnet" {
    source 		      = "./modules/subnet"
    public_subnet   = var.public_subnet
    iVolve	        = module.vpc.iVolve 
 }
```

3. **EC2 Instance**
   - Employs the ./EC2 module to to create an EC2 Instance

- in /EC2 module
```
  resource "aws_instance" "app" {
  count			  	                = length(var.sub_pub)
  ami				                    = data.aws_ami.amazon_ec2.image_id 
  instance_type	                = var.type
  subnet_id			                = var.sub_pub[count.index]
  vpc_security_group_ids	      = [var.app_sg_id]
  monitoring 			              = true 
  associate_public_ip_address 	= true
  key_name                    	= var.key-pair

  tags = {
    Name = "instance-${count.index}"
  }
 }
```
    
- in main.tf
```
  module "instance" {
  source           = "./modules/EC2"
  sub_pub          = [ module.subnet.sub-pub]
  app_sg_id        = module.security-group.app_sg_id
  type 		         = var.type-ec2
  key-pair	       = var.key-pair
 }
```    

4. **Security Groups**
   - Emplous ./sg module to create Security groups to manage the traffice inside the (vpc)
  
- in /sg module
```
resource "aws_security_group" "app_sg" {
  vpc_id = var.iVolve

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public_SecuirtyGroup"
  }
}
```
    
- in main.tf
```
  module "security-group" {
  source  = "./modules/sg"
  iVolve   = module.vpc.iVolve
}

```

4. **Route Tables**
   - Employs ./routetable module to create a route table to manage routing inside the (vpc)

- in /routetable module
```
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
```
    
- in main.tf
```
  module "route-table" {
  source        = "./modules/routetable"
  iVolve        = module.vpc.iVolve
  sub_pub       = [ module.subnet.sub-pub]
  route-cidr    = var.route-cidr
  igw           = module.igw.igw
  tag 		      = var.tag
}

```

5. **Internet Gateway**
   - Employs ./igw to create internet gateway inside the (vpc)
  
- in /igw module
```
  resource "aws_internet_gateway" "igw" {
  vpc_id = var.iVolve
  tags = {
    Name = var.internet-gateway
  }
 }
```
    
- in main.tf
```
  module "igw" {
  source              = "./modules/igw"
  iVolve              = module.vpc.iVolve
  internet-gateway    = var.internet-gateway
   }
```

6. **CloudWatch**
  - Employs ./CloudWatch to monitor the enviroment with alerts

```
  module "cloudwatch" {
  source = "./modules/CloudWatch"
  EC2    = module.instance.ec2_id[0]
  Email  = var.Email
  time   = var.time
  }
```

7. **S3 Bucket**
   - Employs /.s3 to create s3 bucket for bavkend state

- in /igw module
```
  resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  }

  resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
 }
```
    
- in main.tf
```
  module "s3" {
  source        = "./modules/s3"
  bucket_name   = var.bucket_name
  bucket_region = var.bucket_region
 }
```

### Execute Terraform:

1. **Initialize:**
   - Run Command `terraform init` to initialize the created enviroment.

2. **Plan:**
   - Run Command `terraform plan` to see the plan of the created before applying.

3. **Apply:**
   - Run Command `terraform apply` to create your enviroment.

![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/bc88d303-f287-458e-b407-86cd00d03d55)

![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/5ad1e6c6-a944-45ad-a8da-4c66399b6192)

applyyyyyyyyyyyyyyyyyyyyyyyy

4. **Destroy:**
    - Run Command `terraform destroy` to destroy all resources created in your enviroment.

![image](https://github.com/ramy282/MultiCloudDevOpsProject/assets/60857262/011df653-fa1b-4eea-9765-5eb2a06186d9)
