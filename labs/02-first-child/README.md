# Lab: Module 2: call your first local child module

The same Resource Group concept moves into modules/resource-group. This is a NEW isolated lab; it does not migrate the state of Lab 01.

From this lab's directory (except Lab 07, where you first select an environment):

```bash
terraform init
terraform validate
terraform plan
```

When the plan is acceptable and you intend to create resources: `terraform apply`.
Inspect: `terraform state list`. Clean up in the SAME directory/state using `terraform destroy`.
For the VM labs, first create `~/.ssh/id_ed25519.pub` (see the main guide).
Never apply the sample plan to the existing 13-resource state from the earlier Azure variables lab.
