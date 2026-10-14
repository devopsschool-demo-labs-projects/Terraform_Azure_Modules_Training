# Lab 13: Ubuntu VMs with nginx configured from Terraform templates

Self-sufficient lab: one root module creates Ubuntu VMs, installs nginx on them at first boot, and — the main point — **generates the nginx configuration from a Terraform template (`templatefile()`)**. Nothing on the VM is configured by hand.

Provider, credentials and region are taken from the variables-lab project (`/Users/rajesh/training/terraform/first`): azurerm 5.9.0, service-principal auth via `terraform.tfvars` (gitignored), region `West US 3`. That project's state storage account (`motshare`) no longer exists, so this lab keeps remote state in the existing `tfstatedemo123456` account under its **own key** (`lab13-nginx-template.tfstate`) so it never touches any other project's state.

## How the template flow works

```
templates/nginx.conf.tftpl      --templatefile()-->  rendered nginx site config --base64--> \
                                                                                           +--> cloud-init yaml --templatefile()--> custom_data --> VM first boot
templates/cloud-init.yaml.tftpl  (packages: nginx, write_files, runcmd)                  /
```

1. `nginx.conf.tftpl` is rendered per VM with `nginx_port`, `server_name`, `doc_root`, `index_file` and the VM hostname, then base64-encoded.
2. That encoded config is injected as the `nginx_conf_b64` variable into `cloud-init.yaml.tftpl`, which installs nginx, writes the config to `/etc/nginx/sites-available/<site>`, writes an index page, enables the site and restarts nginx (`nginx -t` runs first).
3. The rendered cloud-init YAML becomes the VM's `custom_data`.

Because `custom_data` is **force-new**, any change to a template or to a value feeding it (`nginx_port`, `page_title`, ...) shows up in the plan as a VM replacement — the config on the box can never drift from the templates.

## Files

| File | Purpose |
|---|---|
| `versions.tf` | Terraform + provider version pin (azurerm 5.9.0) |
| `providers.tf` | azurerm backend + provider (copied from the variables-lab project; creds via tfvars, empty = CLI auth) |
| `variables.tf` | Credentials, region, VM settings and the nginx template inputs |
| `main.tf` | RG, VNet/subnet, NSG (22 + `nginx_port`), public IPs, NICs, `count` Ubuntu VMs with templated `custom_data` |
| `templates/nginx.conf.tftpl` | The nginx site config — the star of the lab |
| `templates/cloud-init.yaml.tftpl` | First-boot script: install nginx, apply the rendered config |
| `outputs.tf` | VM names, public IPs, `nginx_urls`, `ssh_commands` |
| `terraform.tfvars.example` | Copy to `terraform.tfvars` and fill in credentials |

## Run this lab

```bash
cp terraform.tfvars.example terraform.tfvars   # then fill in the service principal
terraform init
terraform fmt
terraform validate
terraform plan
```

When the plan is acceptable and you intend to create the (paid) VMs: `terraform apply`.

Verify afterwards:

```bash
terraform output nginx_urls
curl -i http://<public-ip>/        # X-Served-By header shows which templated VM answered
curl http://<public-ip>/health
ssh labadmin@<public-ip> cat /etc/nginx/sites-available/terraform-lab   # head of the rendered template
cloud-init status --long           # on the VM: confirms the templated first boot finished
```

Try the template round-trip: set `nginx_port = 8080` in `terraform.tfvars` and plan again — the NSG rule and the rendered nginx `listen` directive change together, and the plan replaces the VMs.

Clean up in the SAME directory/state using `terraform destroy`. Requires `~/.ssh/id_ed25519.pub` (see the main guide).
