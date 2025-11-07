variable "prefix" {
  description = "Name prefix for resources"
  type        = string
  default     = "platform"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "node_vm_size" {
  description = "VM size for the node pool"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "node_count" {
  description = "Number of nodes in the default pool"
  type        = number
  default     = 2
}

variable "env" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner tag"
  type        = string
  default     = "sfilkov"
}

