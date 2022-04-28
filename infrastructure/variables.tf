# Default variables list 
variable "virtualmachine_name" {
  description = "List of vms to create"
  default = []
}

variable "location" {
  description = "location where to create vm"
  default = "Australia Southeast"
}

variable "tenant_id" {
  description = "Azure tenant ID"
}

variable "client_secret" {
  description = "Azure client secret"
}

variable "client_id" {
  description = "Azure client ID"
}

variable "subscription_id" {
  description = "Azure subscription ID"
}
