module "amba_primary_monitoring" {
  source  = "Azure/avm-ptn-monitoring-amba-alz/azurerm"
  version = "0.3.0"
  providers = {
    azurerm = azurerm.management
  }
  location                            = var.starter_locations[0]
  root_management_group_name          = local.root_management_group_name
  resource_group_name                 = module.config.custom_replacements.primary_amba_resource_group_name
  user_assigned_managed_identity_name = module.config.custom_replacements.primary_amba_user_assigned_managed_identity_name

  # depends_on = [ module.management_groups ]
}