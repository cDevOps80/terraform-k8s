provider "vault" {
  address = "http://127.0.0.1:8200"
  token   = var.token
}

variable "token" {}