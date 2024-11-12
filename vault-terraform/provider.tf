provider "vault" {
  address = "http://44.204.240.222:8200/"
  token   = var.token
}

variable "token" {}