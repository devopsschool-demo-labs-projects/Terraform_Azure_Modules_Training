# Lab: Module 3: required inputs, defaults, module outputs

Copy terraform.tfvars.example to terraform.tfvars. Pass a required name from the root; let the child provide a default tags map.

From this lab's directory (except Lab 07, where you first select an environment):

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
```

When the plan is acceptable and you intend to create resources: `terraform apply`.
Inspect: `terraform output rg_name`. Clean up in the SAME directory/state using `terraform destroy`.
For the VM labs, first create `~/.ssh/id_ed25519.pub` (see the main guide).
Never apply the sample plan to the existing 13-resource state from the earlier Azure variables lab.
