# Azure Kubernetes Service (AKS)

A [Terraform](https://www.terraform.io) module for creating
[`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) resources.
.

- [Azure Kubernetes Service (AKS)](#azure-kubernetes-service-aks)
  - [Prerequisites](#prerequisites)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)
  - [Samples](#samples)

## Prerequisites

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

## Module Features

This module creates [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) resources.

## Getting Started

Most basic usage creating a [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) resource.

```terraform
module "aks" {
  source                         = "."
  environment                    = "development"
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = azurerm_resource_group.rg.location
  k8s_name                       = "k8sSample"
  default_node_pool_name         = "default"
  default_node_pool_node_count   = 3
  default_node_pool_vm_size      = "standard_d2_v2"
  default_node_pool_disk_size_gb = 30
  automatic_channel_upgrade      = "rapid"
  identity_type                  = "SystemAssigned"
  tags = {
    environment = "Demo"
  }
}
```

## Module Argument Reference

See [variables.tf](variables.tf)

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`local_file`**: A file with the kubernetes configuration returned by [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#attributes-reference) **`kube_config_raw`** attribute
- **`kube_config`**: A Kubernetes configuration string returned by [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#attributes-reference) **`kube_config_raw`** attribute
- **`kubernetes_cluster_name`**: The created kubernetes cluster name returned by [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#attributes-reference) **`name`** attribute
- **`kubelet_identity`**: The kubernetes identity returned by [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#attributes-reference) **`kubelet_identity`** attribute

## Samples

You have the samples in [samples folder](../../samples/aks/)
