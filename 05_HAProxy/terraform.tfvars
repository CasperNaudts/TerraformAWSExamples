region = "us-east-1"

key_pair = {
  name         = "main_key_pair"
  private_path = "./key/id_rsa"
  public_path  = "./key/id_rsa.pub"
}

vpc = {
  name = "05_HAProxy_main_VPC"
  cidr_block = "10.0.0.0/16"
}

subnet = {
    name = "web_subnet"
    az   = "us-east-1a"
    cidr = "10.0.0.0/24"
}

ami = {
  # The CentOS AMI should be HVM: https://wiki.centos.org/Cloud/AWS
  # (Make sure the AMI is for the proper region.)
  id   = "ami-0015b9ef68c77328d"
  user = "centos"
}

instance_type = "t2.micro"

web_server_count = 3
