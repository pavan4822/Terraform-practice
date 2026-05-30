resource_values = {
  vpc_cidr = "172.30.0.0/16"
  vpc_name = "qa-vpc"
  subnet_info = {
    sub_cidr = ["172.30.4.0/24", "172.30.6.0/24"]
    sub_az = ["ap-south-1c", "ap-south-1b"]
    sub_name = ["pub-subnet","pvt-subnet"]
    
  }
}
