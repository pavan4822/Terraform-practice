resource_values = {
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "dev-vpc"
  subnet_info = {
    sub_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
    sub_az = ["ap-south-1a", "ap-south-1b", "ap-south-1a", "ap-south-1b"]
    sub_name = ["pub1-subnet", "pvt1-subnet", "pub2-subnet", "pvt2-subnet"]

    
  }
}