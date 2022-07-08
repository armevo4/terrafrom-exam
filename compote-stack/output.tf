output "kgk-SG_id" {
  value = aws_security_group.kgk-SG.id
}

output "kgk-SG_name" {
  value = aws_security_group.kgk-SG.arn
}

output "ec2_pub_ip" {
  value = aws_instance.data-ec2.public_ip
}