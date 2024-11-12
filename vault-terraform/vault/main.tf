resource "vault_mount" "kvv2" {
  path        = var.mount_path
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret for RoboShop"
}

resource "vault_kv_secret_v2" "main" {
  for_each                   = var.secrets
  mount                      = vault_mount.kvv2.path
  name                       = each.key
  cas                        = 1
  data_json                  = jsonencode(each.value["secret_data"])
}

