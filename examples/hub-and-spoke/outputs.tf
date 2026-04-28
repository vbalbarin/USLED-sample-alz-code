output "dns_server_ip_address" {
  value = module.hub_and_spoke_vnet.dns_server_ip_addresses
}

output "hub_and_spoke_vnet_virtual_network_resource_ids" {
  value = module.hub_and_spoke_vnet.virtual_network_resource_ids
}

output "hub_and_spoke_vnet_virtual_network_resource_names" {
  value = module.hub_and_spoke_vnet.virtual_network_resource_names
}

output "hub_and_spoke_vnet_bastion_host_public_ip_address" {
  value = module.hub_and_spoke_vnet.bastion_host_public_ip_address
}

output "hub_and_spoke_vnet_bastion_host_resource_ids" {
  value = module.hub_and_spoke_vnet.bastion_host_resource_ids
}

output "hub_and_spoke_vnet_bastion_host_dns_names" {
  value = module.hub_and_spoke_vnet.bastion_host_dns_names
}

output "hub_and_spoke_vnet_firewall_resource_ids" {
  value = module.hub_and_spoke_vnet.firewall_resource_ids
}

output "hub_and_spoke_vnet_firewall_resource_names" {
  value = module.hub_and_spoke_vnet.firewall_resource_names
}

output "hub_and_spoke_vnet_firewall_private_ip_address" {
  value = module.hub_and_spoke_vnet.firewall_private_ip_addresses
}

output "hub_and_spoke_vnet_firewall_public_ip_addresses" {
  value = module.hub_and_spoke_vnet.firewall_public_ip_addresses
}

output "hub_and_spoke_vnet_firewall_policies" {
  value = module.hub_and_spoke_vnet.firewall_policies
}

output "hub_and_spoke_vnet_route_tables_firewall" {
  value = module.hub_and_spoke_vnet.route_tables_firewall
}

output "hub_and_spoke_vnet_route_tables_user_subnets" {
  value = module.hub_and_spoke_vnet.route_tables_user_subnets
}

output "hub_and_spoke_vnet_full_output" {
  value = module.hub_and_spoke_vnet
}

output "templated_inputs" {
  value = module.config.outputs
}
