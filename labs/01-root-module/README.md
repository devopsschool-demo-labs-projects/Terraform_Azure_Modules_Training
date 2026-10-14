# Lab: Module 1: understand the root module

Only one Azure resource. The current directory is a root module even without any module block.

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
