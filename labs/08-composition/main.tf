module "stack" {
  source         = "./modules/stack"
  project        = "tfmod-08"
  location       = "eastus"
  ssh_public_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}
