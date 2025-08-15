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

variable "frontend_alb_sg_name" {
    default = "frontend_alb"
}

variable "frontend_alb_sg_description" {
    default = "created sg for frontend_alb instance"
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

variable "user_sg_name" {
    default = "catalogue"
}

variable "user_sg_description" {
    default = "created sg for user instance"
}

variable "cart_sg_name" {
    default = "cart"
}

variable "cart_sg_description" {
    default = "created sg for cart instance"
}

variable "shipping_sg_name" {
    default = "shipping"
}

variable "shipping_sg_description" {
    default = "created sg for shipping instance"
}

variable "payment_sg_name" {
    default = "payment"
}

variable "payment_sg_description" {
    default = "created sg for payment instance"
}
variable "Mongodb_ports_vpn" { # just keep as Mongodb_ports
    default = [22, 27017]
}

variable "redis_ports_vpn" {
    default = [22, 6379]
}

variable "mysql_ports_vpn" {
    default = [22, 3306]
}

variable "rabbitmq_ports_vpn" {
    default = [22, 5672]
}