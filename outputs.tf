resource "local_file" "ansible_inventory" {
  filename = "${path.module}/hosts.ini"
  content  = <<EOT
[aws_web]
${aws_instance.web_server.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=./dev_key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
EOT
}

output "instance_ip" {
  value = aws_instance.web_server.public_ip
}  
output "ansible_user" {
  value = aws_instance.web_server.username
}

