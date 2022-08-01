# terraform-null-resource

[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

A [Terraform](https://www.terraform.io) 0.12 module creating a bunch of
[`null_resource`](https://www.terraform.io/docs/providers/null/resource.html) resources to be used in examples.

- [terraform-null-resource](#terraform-null-resource)
  - [Module Features](#module-features)
  - [Getting Started](#getting-started)
  - [Module Argument Reference](#module-argument-reference)
    - [Module Configuration](#module-configuration)
    - [Top-level Arguments](#top-level-arguments)
  - [Module Attributes Reference](#module-attributes-reference)

## Module Features

This module creates a bunch of
[`null_resources`](https://www.terraform.io/docs/providers/null/index.html)
resources and should be mainly used for examples.

## Getting Started

Most basic usage creating a random named secure bucket.

```hcl
module "example" {
  source  = "."

  string          = "Hello World!"
  list_of_strings = ["hello", "world", "!"]

  module_depends_on = [
    null_resource.dependency
  ]
}

resource "null_resource" "dependency" {}
```

## Module Argument Reference

See [variables.tf](variables.tf)

### Module Configuration

- **`module_enabled`**: *(Optional `bool`)*
Specifies whether resources in the module will be created.
Default is `true`.

- **`module_depends_on`**: *(Optional `list(any)`)*
A list of dependencies. Any object can be assigned to this list to define a hidden
external dependency.

### Top-level Arguments

- **`string`**: *(Optional `string`)*
A string.
Default is `""`.

- **`list_of_strings`**: *(Optional `list(string)`)*
A list of strings.
Default is `[]`

## Module Attributes Reference

in addition of all arguments above the following attributes are exported by the module:

- **`single`**: A single null resource object as returned by
  [`null_resource`](https://www.terraform.io/docs/providers/null/resource.html#attributes-reference)
- **`count`**: A list of null resource objects as returned by
  [`null_resource`](https://www.terraform.io/docs/providers/null/resource.html#attributes-reference)
- **`for_each`**: A map of null resource objects keyed by the value of the elements of the input list
  [`null_resource`](https://www.terraform.io/docs/providers/null/resource.html#attributes-reference)
