variable "vmname" {
  default = "vmbootcamp"
}

variable "location" {
  default = "eastus"
    #"displayName": "East US",
    #"id": "/subscriptions/b72d1359-60f3-4e11-80c2-43fc9bd01e2d/locations/eastus",
    #"latitude": "37.3719",
    #"longitude": "-79.8164",
    #"name": "eastus",
    #"subscriptionId": null
}
 
variable "resource_prefix" {
  default = "Bootcamp"
}

variable "azure_subscription_id" { }
variable "azure_client_id" { }
variable "azure_client_secret" { }
variable "azure_tenant_id" { }
variable "vm_admin_username" { }
variable "vm_admin_password" { }
 