# Task 5 - Outputs
output "web_server_instance_public_ip" {
  value = aws_instance.web_server_instance.public_ip
}

output "web_server_instance_private_ip" {
  value = aws_instance.web_server_instance.private_ip
}

output "database_instance_public_ip" {
  value = aws_instance.database_instance.public_ip
}

output "database_instance_private_ip" {
  value = aws_instance.database_instance.private_ip
}

# Assuming you have an IAM user resource defined, replace it with the actual reference
output "iam_user_details" {
  value = aws_iam_user.terraform_user
}
