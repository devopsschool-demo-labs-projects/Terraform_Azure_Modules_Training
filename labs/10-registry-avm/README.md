# Lab: Module 5: use real Terraform Registry community modules

Calls Azure naming plus two Azure Verified Modules (resource group and virtual network). Registry version arguments are pinned.

From this lab's directory (except Lab 07, where you first select an environment):

```bash
terraform init
terraform validate
terraform plan
```

When the plan is acceptable and you intend to create resources: `terraform apply`.
Inspect: `terraform output vnet_id`. Clean up in the SAME directory/state using `terraform destroy`.
For the VM labs, first create `~/.ssh/id_ed25519.pub` (see the main guide).
Never apply the sample plan to the existing 13-resource state from the earlier Azure variables lab.
