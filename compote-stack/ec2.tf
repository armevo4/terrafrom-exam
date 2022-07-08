data "aws_ami" "amazon-linux2-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name = "name"
    values = [
      "amzn2-ami-kernel-*-x86_64-gp2",
    ]
  }
}

resource "aws_instance" "data-ec2" {
  ami                    = data.aws_ami.amazon-linux2-ami.id
  instance_type          = "t2.micro"
  subnet_id              = var.kgk_pub_id
  key_name               = aws_key_pair.public_key.key_name
  vpc_security_group_ids = [aws_security_group.kgk-SG.id]

  #provisioner "local-exec" {
  #  command = "echo 'ipconfig'"
  #}

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/krikor.kafalian/OneDrive - DIGITAIN LLC/Documents/terraform/exam_final/main/exam_rsa")
    host        = self.public_ip
  }

 
 provisioner "file" {
    source      = "/Users/krikor.kafalian/OneDrive - DIGITAIN LLC/Documents/terraform/exam_final/main/exam_rsa"
    destination = "/home/ec2-user/exam_rsa"
  }


  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx",
      "sudo chown -R ec2-user:ec2-user /usr/share/nginx/html",
      "sudo chown -R ec2-user:ec2-user /home/ec2-user/exam_rsa",
      "chmod 400 /home/ec2-user/exam_rsa",
    ]
  }

  provisioner "file" {
    source      = "C:/Users/krikor.kafalian/OneDrive - DIGITAIN LLC/Documents/terraform/exam_final/compote-stack/index.html"
    destination = "/usr/share/nginx/html/index.html"
  }

  tags = {
    Name ="${var.env_prefix}-EC2"
  }
}



