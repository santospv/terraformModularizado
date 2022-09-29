variable "aws_region" {
  description = "Região AWS"
  default     = "us-east-1"
  type        = string
}

variable "vpc_name" {
  description = "nome da VPC"
  type        = string
  default     = "examplo-vpc"
}

variable "vpc_cidr" {
  description = "Bloco CIDR para VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Zonas de disponibilidade para VPC"
  type        = list(string)
  default     = [ "us-east-1a", "us-east-1b", "us-east-1c" ]
}

variable "vpc_private_subnets" {
  description = "Sub-redes privadas para VPC"
  type        = list(string)
  default     = [ "10.0.1.0/24", "10.0.2.0/24" ]
}

variable "vpc_public_subnets" {
  description = "Sub-redes públicas para VPC"
  type        = list(string)
  default     = [ "10.0.101.0/24", "10.0.102.0/24" ]
}

variable "vpc_enable_nat_gateway" {
  description = "Habilitar NAT gateway"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags para aplicar aos recursos criados pelo módulo VPC"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "dev"
  }
}