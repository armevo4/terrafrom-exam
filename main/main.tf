module "network-stack" {
  source = "C:/Users/krikor.kafalian/OneDrive - DIGITAIN LLC/Documents/terraform/exam_final/network-stack"
  vpc_cidr_block      = var.vpc_cidr_block
  pub_sub_cidr_block  = var.pub_sub_cidr_block
  priv_sub_cidr_block = var.priv_sub_cidr_block
  env_prefix          = var.env_prefix   
}

module "compute-stack" {
  source = "C:/Users/krikor.kafalian/OneDrive - DIGITAIN LLC/Documents/terraform/exam_final/compote-stack"
  kgk-VPC_id = module.network-stack.kgk-VPC_id   #(aws_vpc.kgk-VPC.id from network-stack output)
  kgk_pub_id = module.network-stack.kgk_pub_id   #(aws_subnet.kgk-PUBLIC.id from network-stack output)
  env_prefix    = var.env_prefix  
}

output "vpc_id" {
  value = module.network-stack.kgk-VPC_id
}

output "pub_id" {
  value = module.network-stack.kgk_pub_id
}

