# Lab: Module 4: dev and prod in separate roots and states

Run Terraform from environments/dev or environments/prod, not from the parent folder. Both roots reuse modules/linux-vm.

From this lab's directory (except Lab 07, where you first select an environment):

```bash
cd environments/dev
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
# Apply only if you are deliberately deploying this lab.
```

When the plan is acceptable and you intend to create resources: `terraform apply`.
Inspect: `terraform output vm_name`. Clean up in the SAME directory/state using `terraform destroy`.
For the VM labs, first create `~/.ssh/id_ed25519.pub` (see the main guide).
Never apply the sample plan to the existing 13-resource state from the earlier Azure variables lab.
