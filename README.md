# About assets-iac-terraform-azure

Infrastructure as Code (IaC) Terraform modules for Azure. Deploy any of the ready-to-go modules in Azure with just 3 terraform commands.

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

## Prerequisites

To deploy any of the modules, you will need:

- [terraform => 0.13.3](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [az cli => 2.38](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- An Azure Subscription where to deploy everything. Start [here](https://azure.microsoft.com/en-us/free/) for free.

## Modules

- [**AKS**](./modules/aks/README.md)
- [**AKS with Container Registry (ACR)**](./modules/aks_with_container_registry/README.md)
- [**Linux Web App**](./modules/linuxwebapp/README.md)
- [**Windows Web App**](./modules/windowswebapp/README.md)
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

## Deploy your infrastructure

1. Authenticate using the Azure CLI

```
$ az login
```

2. Choose the subscription to use by doing:

```
az account set --subscription <id>
```
3. Browse to the sample you want to deploy by browsing to samples/XXXX.
4. Modify the variables to match your needs at `main.tf`
5. initizlize your terraform configuration:

```
$ terraform init
```
6. Validate your configuration
```
terraform validate
```
7. Plan your Terraform Run
```
$ terraform plan
```
8. Apply your Terraform Configuration
```
$ terraform apply
```

## Destroy your infrastructure

Use terraform destroy to remove infrastructure from your Azure cloud account (in the specific folder where you have the resource).

```
terraform destroy
```

## What's next?

For us, this is just an entrypoint on how to start using and playing around Terraform by following simple steps. Those in the end are just Manual Changes that can evolve to `semi-automated` and real `infrastructure-as-code`.

See the recommended practices of [Terraform](https://www.terraform.io/cloud-docs/recommended-practices) to bring your automatization to the next level!

Also, you can create your own infrastructure and terraform files by following some best practices:

- <https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/small-terraform>
- <https://github.com/antonbabenko/terraform-best-practices/tree/master/examples/medium-terraform>


### `Azure Authentication Important Note`  
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
