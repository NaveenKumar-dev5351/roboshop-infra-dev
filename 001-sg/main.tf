module "frontend" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "bastion" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.bastion_sg_name
    sg_description = var.bastion_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "backend_alb" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.backend_alb_sg_name
    sg_description = var.backend_alb_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}
#bastion accepting connections from my laptop
resource "aws_security_group_rule" "bastion_laptop" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion.sg_id
}

#backend alb accepting connections from bastion host
resource "aws_security_group_rule" "backend_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastion.sg_id
  security_group_id = module.backend_alb.sg_id
}