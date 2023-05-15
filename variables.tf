variable "region" {
  type = string
  default = "ca-central-1"
}

variable "env" {
  type = string
  default = "dev"
}

variable "instanceName" {
  type = string
  default = "my instance"
}
variable "type" {
  type = string
  default = "t3.micro"
}