# About assets-iac-terraform-azure

Infrastructure as Code (IaC) of Terraform modules for Azure

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Built With

- [Terraform ">= 1.1.3"](https://www.terraform.io/)
- [Terraform AzureRm provider version ">= 3.5.0"](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Sonarqube image sonarqube:8.9-developer](https://www.sonarqube.org/)

## Modules

- [**AKS**](./modules/aks/README.md)
- [**AKS with Container Registry (ACR)**](./modules/aks_with_container_registry/README.md)
- [**AppService**](./modules/appservice/README.md)
- [**Container Registry Service**](./modules/containerregistryservice/README.md)
- [**Function**](./modules/function/README.md)
- [**ServiceBus Queues**](./modules/servicebusqueues/README.md)
- [**ServiceBus Topics & Subscriptions**](./modules/servicebustopicssubscriptions/README.md)
- [**SonarQube**](./modules/sonarqube/README.md)
- **Storage**
  - [**Account**](./modules/storage/account/README.md)
  - [**Container**](./modules/storage/container/README.md)
  - [**Queue**](./modules/storage/queue/README.md)
  - [**Table**](./modules/storage/table/README.md)
- [**Terraform Null Resource**](./modules/terraform-null-resource/README.md)

## Getting Started

This is an example of how you may give instructions on setting up your project locally. To get a local copy up and running follow these simple example steps.

## Prerequisites

An existing terraform project where you can import the modules in this repository. Make sure you have something like this first:

- <https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform>
- <https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform>

## Installation

Installation instructions assets-iac-terraform-azure by running:

1. Clone the repo

   ```sh
   git clone https://github.com/ERNI-Academy/assets-iac-terraform-azure.git
   ```

2. Import the modules into your existing terraform project. The azurerm provider is mandatory, make sure you include a reference to the provider like this:

   ```terraform
    terraform {
        required_providers {
            azurerm = {
                source = "hashicorp/azurerm"
                version = ">= [version]"
            }
        }
    }

    provider "azurerm" {
        features {}
    }
   ```

3. Call the desire module, to see mandatory variables take a look at variables.tf file for each module

    ```terraform
        module "function" {
            source = "[path to module]/function"

            # make sure you pass all mandatory variables
        }
    ```

   > `Depends on Important Note`  
   > Some modules expects that you have resources created. e.g. a Resource Group. Then make sure you include a "depends_on"

4. Execute the modules by running the following [terraform commands](https://www.terraform.io/cli/commands):
   1. Authenticate using the Azure CLI
      login to the Azure CLI. How to install [az cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

    ```bash
    az login
    ```

   2. Choose the subscription to use by doing:

   ```bash
    az account set --subscription <id>
   ```

   3. Browse to the module you want to deploy by browsing to modules/XXXX

   4. Modify the variables to match your needs at modules/XXXX/terraform.tfvars and/or variables.tf

   5. initizlize your terraform configuration:

    ```bash
    terraform init
    ```

   6. Validate your terraform configuration

    ```bash
    terraform validate
    ```

   7. Plan your Terraform Run

    ```bash
    terraform plan
    ```

   8. Apply your Terraform Configuration

   ```bash
   terraform apply
   ```

    > `Azure Authentication Important Note`  
    > In order to provisioning the resources in Azure using the modules on this repository, you need to be authenticated first. Take a look at those links.
    >
    > - [Azure Provider: Authenticating using a Service Principal with a Client Certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_certificate)
    > - [Azure Provider: Authenticating using a Service Principal with a Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
    > - [Azure Provider: Authenticating using managed identities for Azure resources](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/managed_service_identity)
    > - [Azure Provider: Authenticating using the Azure CLI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

## Contributing

Please see our [Contribution Guide](CONTRIBUTING.md) to learn how to contribute.

## License

![MIT](https://img.shields.io/badge/License-MIT-blue.svg)

(LICENSE) © 2022 [ERNI - Swiss Software Engineering](https://www.betterask.erni)

## Code of conduct

Please see our [Code of Conduct](CODE_OF_CONDUCT.md)

## Stats

![Alt](https://repobeats.axiom.co/api/embed/66328217228da1e2beec04e6df2a552bd793a636.svg "Repobeats analytics image")

## Follow us

[![Twitter Follow](https://img.shields.io/twitter/follow/ERNI?style=social)](https://www.twitter.com/ERNI)
[![Twitch Status](https://img.shields.io/twitch/status/erni_academy?label=Twitch%20Erni%20Academy&style=social)](https://www.twitch.tv/erni_academy)
[![YouTube Channel Views](https://img.shields.io/youtube/channel/views/UCkdDcxjml85-Ydn7Dc577WQ?label=Youtube%20Erni%20Academy&style=social)](https://www.youtube.com/channel/UCkdDcxjml85-Ydn7Dc577WQ)
[![Linkedin](https://img.shields.io/badge/linkedin-31k-green?style=social&logo=Linkedin)](https://www.linkedin.com/company/erni)

## Contact

📧 [esp-services@betterask.erni](mailto:esp-services@betterask.erni)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/omaramalfi"><img src="https://avatars.githubusercontent.com/u/85349124?v=4?s=100" width="100px;" alt=""/><br /><sub><b>omaramalfi</b></sub></a><br /><a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=omaramalfi" title="Code">💻</a> <a href="#content-omaramalfi" title="Content">🖋</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=omaramalfi" title="Documentation">📖</a> <a href="#design-omaramalfi" title="Design">🎨</a> <a href="#ideas-omaramalfi" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-omaramalfi" title="Maintenance">🚧</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=omaramalfi" title="Tests">⚠️</a> <a href="#example-omaramalfi" title="Examples">💡</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/pulls?q=is%3Apr+reviewed-by%3Aomaramalfi" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/Rabosa616"><img src="https://avatars.githubusercontent.com/u/12774781?v=4?s=100" width="100px;" alt=""/><br /><sub><b>rabosa616</b></sub></a><br /><a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=rabosa616" title="Code">💻</a> <a href="#content-rabosa616" title="Content">🖋</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=rabosa616" title="Documentation">📖</a> <a href="#design-rabosa616" title="Design">🎨</a> <a href="#ideas-rabosa616" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-rabosa616" title="Maintenance">🚧</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=rabosa616" title="Tests">⚠️</a> <a href="#example-rabosa616" title="Examples">💡</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/pulls?q=is%3Apr+reviewed-by%3Arabosa616" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="https://github.com/albertinisg"><img src="https://avatars.githubusercontent.com/u/8257425?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Alberto Martín</b></sub></a><br /><a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=albertinisg" title="Code">💻</a> <a href="#content-albertinisg" title="Content">🖋</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=albertinisg" title="Documentation">📖</a> <a href="#design-albertinisg" title="Design">🎨</a> <a href="#ideas-albertinisg" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-albertinisg" title="Maintenance">🚧</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/commits?author=albertinisg" title="Tests">⚠️</a> <a href="#example-albertinisg" title="Examples">💡</a> <a href="https://github.com/ERNI-Academy/assets-iac-terraform-azure/pulls?q=is%3Apr+reviewed-by%3Aalbertinisg" title="Reviewed Pull Requests">👀</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
