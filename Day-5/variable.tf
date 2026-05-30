variable "resource_values"{
type = object({
  vpc_cidr = string
  vpc_name = string
  subnet_info = object({
    sub_cidr = list(string)
    sub_az = list(string)
    sub_name  = list(string)
    

})
})
}