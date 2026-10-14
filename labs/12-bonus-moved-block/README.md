# Bonus: `moved` block state-safe refactor

1. `cd before`, then `terraform init`, `terraform plan`, `terraform apply`.
2. **In that same `before/` directory**, save a private state backup.
3. Still in `before/`, execute `cp -R ../after/. ./` (this overwrites config; keeps local state).
4. Run `terraform init`, `terraform plan`. Confirm it says the resource *has moved*, not destroy/create.
5. Once reviewed, `terraform apply`, `terraform state list`, `terraform destroy`.

This teaches how to safely move resource addresses in an already-applied state. Never repeat these state edits blindly on the earlier 13-resource Windows/Ubuntu lab.
