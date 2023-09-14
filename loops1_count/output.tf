output "private-ip" {
    value = aws_instance.loops-using-count[*].private_ip
}
