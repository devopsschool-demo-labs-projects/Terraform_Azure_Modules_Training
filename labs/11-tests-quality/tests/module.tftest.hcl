# The provider is mocked: no Azure resources are created by this test.
mock_provider "azurerm" {}

run "accept_valid_resource_group_name" {
  command = plan

  assert {
    condition     = module.rg.name == "rg-tfmod-11"
    error_message = "The child module should preserve the requested name."
  }
}

run "reject_invalid_resource_group_name" {
  command = plan

  variables {
    rg_name = "bad-name"
  }

  expect_failures = [var.rg_name]
}
