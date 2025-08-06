variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "frontend_sg_name" {
    default = "frontend"
}

variable "frontend_sg_description" {
    default = "created sg for frontend instance"
}

variable "bastion_sg_name" {
    default = "bastion"
}

variable "bastion_sg_description" {
    default = "created sg for bastion instance"
}

variable "backend_alb_sg_name" {
    default = "backend_alb"
}

variable "backend_alb_sg_description" {
    default = "created sg for backend_alb instance"
}

variable "Mongodb_sg_name" {
    default = "Mongodb"
}

variable "Mongodb_sg_description" {
    default = "created sg for Mongodb instance"
}

variable "redis_sg_name" {
    default = "redis"
}

variable "redis_sg_description" {
    default = "created sg for redis instance"
}

variable "mysql_sg_name" {
    default = "mysql"
}

variable "mysql_sg_description" {
    default = "created sg for mysql instance"
}

variable "rabbitmq_sg_name" {
    default = "rabbitmq"
}

variable "rabbitmq_sg_description" {
    default = "created sg for rabbitmq instance"
}

variable "catalogue_sg_name" {
    default = "catalogue"
}

variable "catalogue_sg_description" {
    default = "created sg for catalogue instance"
}
/* variable "vpn_ports" {
  default = [22, 443, 1194, 943]
} */