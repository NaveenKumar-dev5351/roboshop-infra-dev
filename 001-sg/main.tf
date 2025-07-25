module "frontend" {
    source = "../../terraform-aws-sg"
    project = var.project
    environment = var.environment
    sg_name = var.frontend_sg_name
    sg_description = var.frontend_sg_description
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}