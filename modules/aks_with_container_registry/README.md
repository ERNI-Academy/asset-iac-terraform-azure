# Azure Kubernetes Service (AKS) with Azure Container Registry Service (ACR)

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module for creating
[`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) resources with [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) resource.
.

- [Azure Kubernetes Service (AKS) with Azure Container Registry Service (ACR)](#azure-kubernetes-service-aks-with-azure-container-registry-service-acr)
  - [Prerequisits](#prerequisits)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
  - [Module Attributes Reference](#module-attributes-reference)
  - [Samples](#samples)

## Prerequisits

To use this module you need the following resources:

- [`Azure Resource Group`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

## Module Features

This module creates [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) resources with [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) resource.

## Getting Started

Most basic usage creating a [`Azure Kubernetes Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) resource with [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) resource.

```terraform
module "k8s" {
  source                         = "."
  environment                    = "development"
  resource_group_name            = azurerm_resource_group.rg.name
  location                       = azurerm_resource_group.rg.location
  container_name                 = "k8sSample"
  container_sku                  = "Basic"
  container_admin_enabled        = true
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
- **`container_registry_id`**: The create container registry id returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_id`** attribute
- **`container_registry_name`**: The created container registry name returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_id`** attribute
- **`container_registry_login_server`**: The url to connect with the created container registry service returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_login_server`** attribute
- **`container_registry_fqdn`**: The FQDN of the created container registry service returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_fqdn`** attribute
- **`container_registry_admin_username`**: The Username associated with the Container Registry Admin account - if the admin account is enabled, returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_admin_username`** attribute
- **`container_registry_admin_password`**: The Password associated with the Container Registry Admin account - if the admin account is enabled, returned by [`Azure Container Registry Service`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry#attributes-reference) **`container_registry_admin_password`** attribute

## Samples

You have the samples in [samples folder](../../samples/aks_with_container_registry/)
