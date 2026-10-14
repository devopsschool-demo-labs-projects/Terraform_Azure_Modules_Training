# Lab: Module 4: build a small reusable Linux VM module

The root creates just a resource group, VNet and subnet. The child module owns the NIC and private-only Ubuntu VM.

From this lab's directory (except Lab 07, where you first select an environment):

```bash
terraform init
terraform validate
terraform plan
```

When the plan is acceptable and you intend to create resources: `terraform apply`.
Inspect: `terraform output private_ip`. Clean up in the SAME directory/state using `terraform destroy`.
For the VM labs, first create `~/.ssh/id_ed25519.pub` (see the main guide).
Never apply the sample plan to the existing 13-resource state from the earlier Azure variables lab.
