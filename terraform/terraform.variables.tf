# Global Variables
variable "rg_name" {
  description = "Name of Resource Group"
  type        = string
  default     = "aks-global-deployment"
}

variable "rg_location" {
  description = "Location of Resource Group"
  type        = string
  default     = "West Europe"
}

variable "aks_name" {
  description = "Name of AKS Cluster"
  type = string
  default = "main-aks"
}

variable "aks_node_vm_size" {
  description = "Size of VMs for the main Node Pool"
  type = string
  default = "Standard_D2_v2"
}

variable "aks_node_pool_name" {
  description = "Name of default Node Pool"
  type = string
  default = "mynodepool"
}

variable "tags" {
  description = "Map of tags to use in resources"
  type = map(string)
  default = {
    Environment = "Development"
  }
}
