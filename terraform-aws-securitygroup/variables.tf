#mandatory variable to pass
variable "vpc_id" {

}
variable "sg_name" {

}

variable "sg_description" {
    default =""
}

#mandatory variable to pass
variable "project_name" {

}

variable "common_tags" {
    default = {}
}

variable "sg_tags" {
    default = {}
}

variable "sg_ingress_rules" {
  default = []
}




