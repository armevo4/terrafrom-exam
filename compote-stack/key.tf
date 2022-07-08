resource "aws_key_pair" "public_key" {
  key_name   = "exam_rsa_pub"
  public_key = file("C:/Users/krikor.kafalian/OneDrive - DIGITAIN LLC/Documents/terraform/exam_final/main/exam_rsa.pub")
}

