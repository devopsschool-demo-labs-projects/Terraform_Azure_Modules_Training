# Resource Group teaching module

Small module used for the test and maintenance lab. It creates **one** Azure Resource Group. Configure AzureRM only in the calling root; the child declares its `required_providers`.

## Input interface

| Name | Type | Required? | Description |
|---|---|---|---|
| `name` | `string` | Yes | Resource group name |
| `location` | `string` | Yes | Azure region |
| `tags` | `map(string)` | No | Default course tag provided |

## Output interface

| Name | Meaning |
|---|---|
| `name` | Azure resource group name |
| `id` | Azure resource group resource ID |

## Example root call

```hcl
module "rg" {
  source   = "./modules/resource-group"
  name     = "rg-tfmod-11"
  location = "eastus"
}
```

## Quality and release checklist

Run `terraform fmt -recursive`, `terraform validate`, and `terraform test` (from the root). Review output/variable interface compatibility before tagging a new module release. Use a provider minimum requirement in this module and a tested, bounded provider constraint in the root.
