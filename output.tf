#output public ip-address 
output "public_ip" {
  value       = aws_instance.web.public_ip
  description = "public ip address."
}
output "instance_id" {
  value       = aws_instance.web.id
  description = "instance id"
}
