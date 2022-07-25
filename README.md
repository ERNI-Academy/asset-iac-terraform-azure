# About assets-iac-terraform-azure

Infrastructure as Code (IaC) of Terraform modules for Azure

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Built With

- [Terraform ">= 1.1.3"](https://www.terraform.io/)
- [Terraform AzureRm provider version ">= >= 3.5.0"](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Sonarqube image sonarqube:8.9-developer](https://www.sonarqube.org/)

## Modules

- Azure App Service
- Azure Function
- Sonarqube hosted in linux app service plan with docker compose and sql server
- Servicebus topics and queues

## Getting Started

This is an example of how you may give instructions on setting up your project locally. To get a local copy up and running follow these simple example steps.

## Prerequisites

An existing terraform project where you can import the modules in this repository. Make sure you have something like this first:
 * https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform
 * https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform

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
    * login
        * az login
            > login to the Azure CLI. How to install [az cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
        * az account list
            > To list the Subscriptions. It is possible to have more than one subscription, if you have more than one then select using this command: az account set --subscription="SUBSCRIPTION_ID"

    * terraform init 
        > Prepare your working directory for other commands
    * terraform validate
        > Check whether the configuration is valid
    * terraform plan
        > Show changes required by the current configuration
    * terraform apply
        > Create or update infrastructure

    > `Azure Authentication Important Note`  
    > In order to provisioning the resources in Azure using the modules on this repository, you need to be authenticated first. Take a look at those links.
    > * [Azure Provider: Authenticating using a Service Principal with a Client Certificate](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_certificate)
    > * [Azure Provider: Authenticating using a Service Principal with a Client Secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret)
    > * [Azure Provider: Authenticating using managed identities for Azure resources](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/managed_service_identity)
    > * [Azure Provider: Authenticating using the Azure CLI](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli) 

## Examples

### function module

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

    resource "azurerm_resource_group" "rg" {
        name = "MyRg"
        location = "West Europe"
        tags =  {
            MyTag = "MyTag value"
        }
    }

    module "function" {
        source = "[path to module]/function"

        resource_group_name = azurerm_resource_group.rg.name
        location = azurerm_resource_group.rg.location
        function_name = "myfnapp"
        environment = "DEV"
        law_id = "[id of your analytics workspace that you need to create first]" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

        tags =  {
            MyTag = "MyTag value"
        }

        depends_on = [
            azurerm_resource_group.rg
        ]
    }  
```

### appservice module

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

    resource "azurerm_resource_group" "rg" {
        name = "MyRg"
        location = "West Europe"
        tags =  {
            MyTag = "MyTag value"
        }
    }

    module "appservice" {
        source = "[path to module]/appservice"

        resource_group_name = azurerm_resource_group.rg.name
        location = azurerm_resource_group.rg.location
        app_name = "myapp"
        environment = "DEV"
        plan_id = "[id of your app service plan that you need to create first]" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan
        law_id = "[id of your analytics workspace that you need to create first]" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

        tags =  {
            MyTag = "MyTag value"
        }

        depends_on = [
            azurerm_resource_group.rg
        ]
    } 
```

### sonarqube module

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

    module "sonarqube" {
        source = "[path to module]/sonarqube"

        resource_group_name = "mysonarqube123"
        account_name = "mysonarqube123"
        sql_server_name = "mysonarqube122"
        app_service_plan_name = "mysonarqube123"
        sonarqube_instances = [ "sonarqube-for-organization-a", "sonarqube-for-organization-b" ]

        tags =  {
            MyTag = "MyTag value"
        }
    }
    
    # Sadly there is a manual step you need to copy the profile.json to share "${var.instanceName}-sonarqube-conf"
```

### servicebustopicssubscriptions module

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

    module "servicebus_topics_subscriptions" {
        source = "[path to module]/servicebustopicssubscriptions"

        service_bus_id =  "myservicebusid"
        topics_subscriptions = [
            {
                topic_name = "topicA",
                subscription_name = "sub1"
            },
            {
                topic_name = "topicA",
                subscription_name = "sub2"
            },
            {
                topic_name = "topicB",
                subscription_name = "sub3"
            }
        ]
    }
```

### servicebusqueues module

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

    module "servicebusqueues" {
        source = "[path to module]/servicebusqueues"

        service_bus_id =  "myservicebusid"
        queues = ["queueA", "queueB"]
    }
```

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
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
