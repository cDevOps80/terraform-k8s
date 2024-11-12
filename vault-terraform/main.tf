module "roboshop_vault" {
  source     = "./vault"
  mount_path = var.roboshop-dev["mount_path"]
  secrets    = var.roboshop-dev["secrets"]
}

variable "roboshop-dev" {
  default = {
    mount_path = "roboshop-dev"
    secrets    = {
      frontend = {
        secret_data ={
          "cart": "cart",
          "catalogue": "catalogue",
          "payment": "payment",
          "shipping": "shipping",
          "user": "user"
        }
      }
      cart     = {
        secret_data = {
          "CATALOGUE_HOST": "catalogue",
          "CATALOGUE_PORT": "8080",
          "REDIS_HOST": "10.0.6.168"
        }
      }
      catalogue = {
        secret_data = {
          "MONGO" : "true",
          "MONGO_URL" : "mongodb://10.0.6.168:27017/catalogue",
          "one" : "one"
        }
      }
      catalogue-load = {
        secret_data = {
          "CODE_URL" : "https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip",
          "COMPONENT" : "mongo",
          "MONGO_DB_ADDRESS" : "10.0.6.168",
          "SCHEMA_FILE" : "/app/db/master-data.js"
        }
      }
      user     = {
        secret_data = {
          "MONGO_URL" : "mongodb://10.0.6.168:27017/users",
          "REDIS_URL" : "redis://10.0.6.168:6379"
        }
      }
      shipping = {
        secret_data = {
          "CART_ENDPOINT" : "cart:8080",
          "DB_HOST" : "10.0.6.168"
        }
      }
      shipping-load = {
        secret_data = {
          "CODE_URL" : "https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip",
          "COMPONENT" : "mysql",
          "MYSQL_ADDRESS" : "10.0.6.168",
          "MYSQL_PASSWORD" : "RoboShop@1",
          "MYSQL_USER" : "root",
          "SCHEMA_FILE" : "/app/db"
        }
      }
      payment  = {
        secret_data = {
          "AMQP_HOST" : "10.0.6.168",
          "AMQP_PASS" : "roboshop123",
          "AMQP_USER" : "roboshop",
          "CART_HOST" : "cart",
          "CART_PORT" : "8080",
          "USER_HOST" : "user",
          "USER_PORT" : "8080"
        }
      }

    }
  }
}
