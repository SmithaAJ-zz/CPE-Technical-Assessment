# Default variables list 
variable "virtualmachine_name" {
  description = "List of vms to create"
  default = []
}

variable "location" {
  description = "location where to create vm"
  default = "Australia Southeast"
}