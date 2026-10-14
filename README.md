# Terraform Modules — Azure Hands-On Training

**Main document:** [`Terraform_Modules_Step_by_Step_Azure_Training.md`](Terraform_Modules_Step_by_Step_Azure_Training.md).

This pack contains one self-contained Markdown guide with complete code listings, and 12 gradually progressing exercise folders with runnable HCL/config examples. Labs 01–11 use separate root states. Bonus Lab 12 deliberately demonstrates safe in-place resource address migration.

## Quick start

1. Read the prerequisite and state-safety sections in the main guide.
2. For a first exercise: `cd labs/01-root-module && terraform init && terraform validate && terraform plan`.
3. For VM exercises, generate the SSH public key described in the guide.
4. Never run an `apply` against the older Azure variables course state or an unintended Azure subscription.
5. Delete an optional lab deployment with `terraform destroy` from the **same** root/state where it was created.

A `.gitignore` is provided. Real `.terraform.lock.hcl` files are intentionally not included because this package could not initialize/download providers in its build environment. In your own Git repository, commit dependency lock files after successful `terraform init`, while excluding secrets/state files.
