# Lab: Module 3: validation and sensitive values

Copy terraform.tfvars.example, set a disposable TF_VAR_training_secret environment variable, and observe redaction. Sensitive data can still exist in Terraform state.

From this lab's directory (except Lab 07, where you first select an environment):

```bash
cp terraform.tfvars.example terraform.tfvars
export TF_VAR_training_secret="throwaway-training-value"
terraform init
terraform validate
terraform plan
```

When the plan is acceptable and you intend to create resources: `terraform apply`.
Inspect: `terraform output redacted_demo`. Clean up in the SAME directory/state using `terraform destroy`.
For the VM labs, first create `~/.ssh/id_ed25519.pub` (see the main guide).
Never apply the sample plan to the existing 13-resource state from the earlier Azure variables lab.
