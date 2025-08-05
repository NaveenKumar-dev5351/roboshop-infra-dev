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

module "vpn" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = "vpn"
    sg_description = "for vpn"
    vpc_id = local.vpc_id
}

module "Mongodb" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.Mongodb_sg_name
    sg_description = var.Mongodb_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "redis" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.redis_sg_name
    sg_description = var.redis_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "mysql" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.mysql_sg_name
    sg_description = var.mysql_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}

module "Rabbitmq" {
    #source = "../../terraform-aws-sg"
    source = "git::https://github.com/NaveenKumar-dev5351/terraform-aws-sg.git?ref=main"
    project = var.project
    environment = var.environment

    sg_name = var.Rabbitmq_sg_name
    sg_description = var.Rabbitmq_sg_description
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

resource "aws_security_group_rule" "mongodb_ingress_from_vpn" {
  for_each = toset([for p in [22,27017] : tostring(p)])


  type                     = "ingress"
  from_port                = each.value
  to_port                  = each.value
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.Mongodb.sg_id
}

resource "aws_security_group_rule" "redis_ingress_from_vpn" {
  for_each = toset([for p in [22,6379] : tostring(p)])


  type                     = "ingress"
  from_port                = each.value
  to_port                  = each.value
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "mysql_ingress_from_vpn" {
  for_each = toset([for p in [22,3306] : tostring(p)])


  type                     = "ingress"
  from_port                = each.value
  to_port                  = each.value
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "Rabbitmq_ingress_from_vpn" {
  for_each = toset([for p in [22,5672] : tostring(p)])


  type                     = "ingress"
  from_port                = each.value
  to_port                  = each.value
  protocol                 = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id        = module.Rabbitmq.sg_id
}

resource "aws_security_group_rule" "vpn_ingress" {
  for_each = toset([for p in [22, 443, 1194, 943] : tostring(p)])

  type              = "ingress"
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}


