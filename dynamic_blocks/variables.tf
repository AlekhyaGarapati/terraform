variable "inboundrules" {
    type = list
    default = [
        {description = "Allowing http"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]},
       {description = "Allowing https"
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]},
       {description = "Allowing SSH"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]},
        ]
}