# About assets-iac-terraform-azure

Infrastructure as Code (IaC) of Terraform modules for Azure

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Built With

- [Terraform ">= 1.1.3"](https://www.terraform.io/)
- [Terraform AzureRm provider version ">= 2.93.0"](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Sonarqube image sonarqube:8.9-developer](https://www.sonarqube.org/)

## Modules

- Azure App Service
- Azure Function
- Sonarqube hosted in linux app service plan with docker compose and sql server

## Getting Started

This is an example of how you may give instructions on setting up your project locally. To get a local copy up and running follow these simple example steps.

## Prerequisites

This is an example of how to list things you need to use the software and how to install them.

## Installation

Installation instructions assets-iac-terraform-azure by running:

1. Clone the repo

   ```sh
   git clone https://github.com/ERNI-Academy/assets-iac-terraform-azure.git
   ```

2. Import the modules into your existing terraform configuration. The azurerm provider is mandatory, make sure you include a reference to the provider like this:

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

            depends_on = [
                azurerm_resource_group.rg,
            ]

            resourceGroupName = azurerm_resource_group.rg.name
            location = azurerm_resource_group.rg.location
            functionName = "myfnapp"
            environment = "DEV"
            lawId = "[id of your analytics workspace that you need to create first]"
            tags =  {
                MyTag = "MyTag value"
            }
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

            depends_on = [
                azurerm_resource_group.rg,
            ]

            resourceGroupName = azurerm_resource_group.rg.name
            location = azurerm_resource_group.rg.location
            appName = "myapp"
            environment = "DEV"
            planId = "[id of app service plan that you need to create first]"
            lawId = "[id of your analytics workspace that you need to create first]"
            tags =  {
                MyTag = "MyTag value"
            }
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

            resourceGroupName = "SONARQUBE"
            accountName = "mysonarqube"
            sqlServerName = "mysonarqube"
            sonarqubeInstances = [ "sonarqube-for-organization-a", "sonarqube-for-organization-b" ]
        }
        
        # Sadly there is a manual step you need to copy the profile.json to share "${var.instanceName}-sonarqube-conf"
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
<!-- ALL-CONTRIBUTORS-LIST:END -->
This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
