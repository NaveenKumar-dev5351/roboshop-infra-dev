locals {
    ami_id = data.aws_ami.joindevops.id
    Mongodb_sg_id = data.aws_ssm_parameter.Mongodb_sg_id.value
    redis_sg_id = data.aws_ssm_parameter.redis_sg_id.value
    mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
    Rabbitmq_sg_id = data.aws_ssm_parameter.Rabbitmq_sg_id.value


    database_subnet_ids = split (",", data.aws_ssm_parameter.database_subnet_ids.value)[0]

    common_tags = {
        Project = var.project
        Environment = var.environment
        Terraform = "true"
    }
}
