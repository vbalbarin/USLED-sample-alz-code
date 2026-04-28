/*
--- Built-in Replacements ---
This file contains built-in replacements to avoid repeating the same hard-coded values.
Replacements are denoted by the dollar-dollar curly braces token (e.g. $${starter_location_01}). The following details each built-in replacemnets that you can use:
`starter_location_01`: This the primary an Azure location sourced from the `starter_locations` variable. This can be used to set the location of resources.
`starter_location_02` to `starter_location_10`: These are the secondary Azure locations sourced from the `starter_locations` variable. This can be used to set the location of resources.
`starter_location_01_availability_zones` to `starter_location_10_availability_zones`: These are the availability zones for the Azure locations sourced from the `starter_locations` variable. This can be used to set the availability zones of resources.
`starter_location_01_virtual_network_gateway_sku_express_route` to `starter_location_10_virtual_network_gateway_sku_express_route`: These are the default SKUs for the Express Route virtual network gateways based on the Azure locations sourced from the `starter_locations` variable. This can be used to set the SKU of the virtual network gateways.
`starter_location_01_virtual_network_gateway_sku_vpn` to `starter_location_10_virtual_network_gateway_sku_vpn`: These are the default SKUs for the VPN virtual network gateways based on the Azure locations sourced from the `starter_locations` variable. This can be used to set the SKU of the virtual network gateways.
`root_parent_management_group_id`: This is the id of the management group that the ALZ hierarchy will be nested under.
`subscription_id_identity`: The subscription ID of the subscription to deploy the identity resources to, sourced from the variable `subscription_id_identity`.
`subscription_id_connectivity`: The subscription ID of the subscription to deploy the connectivity resources to, sourced from the variable `subscription_id_connectivity`.
`subscription_id_management`: The subscription ID of the subscription to deploy the management resources to, sourced from the variable `subscription_id_management`.
*/

#  If you leave this value blank, it will create the landing zone management groups under the tenant root group. If you need to create it under another intermediary management group,
# please specify the management group id here and go to the lib/architecture_definitions/alz_custom.yaml file to update the parent_id property on line 8 with the same management group id as this.
root_parent_management_group_id = "TO-BE-UPDATED"
starter_locations = [
  "TO-BE-UPDATED"
]

starter_locations_short = {}

subscription_ids = {
  management   = "TO-BE-UPDATED", # Requires the ManagedIdntity, Insights, OperationalInsights, and PolicyInsights providers registered
  identity     = "TO-BE-UPDATED", # Requires the PolicyInsights provider registered
  connectivity = "TO-BE-UPDATED", # Requires the Network provider registered
  security     = "TO-BE-UPDATED"
}

enable_telemetry = true

management_resources_enabled = true
management_groups_enabled    = true
management_resource_settings = {
  location                        = "$${starter_location_01}"
  log_analytics_workspace_name    = "$${primary_log_analytics_workspace_name}"
  log_analytics_solution_plans    = []
  sentinel_onboarding             = null # This is an object with a name and customer_managed_key_enable property, if you want to onboard Sentinel during deployment
  resource_group_name             = "$${primary_management_resource_group_name}"
  resource_group_creation_enabled = true
  user_assigned_managed_identities = {
    ama = {
      name = "$${primary_ama_user_assigned_managed_identity_name}"
    }
  }
  automation_account_name                          = "$${primary_automation_account_name}"
  automation_account_sku_name                      = "Basic"
  automation_account_public_network_access_enabled = false
  automation_account_local_authentication_enabled  = false


  data_collection_rules = {
    change_tracking = {
      name    = "$${dcr_change_tracking_name}"
      enabled = true
    }
    defender_sql = {
      name    = "$${dcr_defender_sql_name}"
      enabled = true
    }
    vm_insights = {
      name    = "$${dcr_vm_insights_name}"
      enabled = true
    }
  }
}

management_group_settings = {
  location           = "$${starter_location_01}"
  parent_resource_id = "$${root_parent_management_group_id}"
  architecture_name  = "alz_custom" # This param is used to reference the custom architecture definition YAML file in the lib/architecture_definitions folder. The management group hierarchy will be built based on the structure defined in that file.
  policy_default_values = {
    ama_change_tracking_data_collection_rule_id    = "$${primary_ama_change_tracking_data_collection_rule_id}"
    ama_mdfc_sql_data_collection_rule_id           = "$${primary_ama_mdfc_sql_data_collection_rule_id}"
    ama_vm_insights_data_collection_rule_id        = "$${primary_ama_vm_insights_data_collection_rule_id}"
    ama_user_assigned_managed_identity_id          = "$${primary_ama_user_assigned_managed_identity_id}"
    ama_user_assigned_managed_identity_name        = "$${primary_ama_user_assigned_managed_identity_name}"
    log_analytics_workspace_id                     = "$${primary_log_analytics_workspace_id}"
    amba_alz_management_subscription_id            = "$${subscription_id_management}"
    amba_alz_resource_group_location               = "$${starter_location_01}"
    amba_alz_resource_group_name                   = "$${primary_amba_resource_group_name}"
    amba_alz_user_assigned_managed_identity_name   = "$${primary_amba_user_assigned_managed_identity_name}"
    amba_alz_action_group_email                    = []
    amba_alz_arm_role_id                           = []
    amba_alz_resource_group_tags                   = {}
    amba_alz_byo_user_assigned_managed_identity_id = ""
    amba_alz_disable_tag_name                      = ""
    amba_alz_disable_tag_values                    = []
    amba_alz_webhook_service_uri                   = []
    amba_alz_event_hub_resource_id                 = []
    amba_alz_function_resource_id                  = ""
    amba_alz_function_trigger_url                  = ""
    amba_alz_logicapp_resource_id                  = ""
    amba_alz_logicapp_callback_url                 = ""
    amba_alz_byo_alert_processing_rule             = ""
    amba_alz_byo_action_group                      = []
  }

  management_group_hierarchy_settings = {
    default_management_group_name            = "TO-BE-UPDATED"
    require_authorization_for_group_creation = true
    update_existing                          = false
  }

  subscription_placement = {
    identity = {
      subscription_id       = "$${subscription_id_identity}"
      management_group_name = "identity"
    }
    connectivity = {
      subscription_id       = "$${subscription_id_connectivity}"
      management_group_name = "connectivity"
    }
    management = {
      subscription_id       = "$${subscription_id_management}"
      management_group_name = "management"
    }
  }
  policy_assignments_to_modify = {
    # alz = {
    #   policy_assignments = {
    #     Deploy-MDFC-Config-H224 = {
    #       parameters = {
    #         ascExportResourceGroupName                  = "$${asc_export_resource_group_name}"
    #         ascExportResourceGroupLocation              = "$${starter_location_01}"
    #         emailSecurityContact                        = "$${defender_email_security_contact}"
    #         enableAscForServers                         = "DeployIfNotExists"
    #         enableAscForServersVulnerabilityAssessments = "DeployIfNotExists"
    #         enableAscForSql                             = "DeployIfNotExists"
    #         enableAscForAppServices                     = "DeployIfNotExists"
    #         enableAscForStorage                         = "DeployIfNotExists"
    #         enableAscForContainers                      = "DeployIfNotExists"
    #         enableAscForKeyVault                        = "DeployIfNotExists"
    #         enableAscForSqlOnVm                         = "DeployIfNotExists"
    #         enableAscForArm                             = "DeployIfNotExists"
    #         enableAscForOssDb                           = "DeployIfNotExists"
    #         enableAscForCosmosDbs                       = "DeployIfNotExists"
    #         enableAscForCspm                            = "DeployIfNotExists"
    #       }
    #     }
    #   }
    # }
    connectivity = {
      policy_assignments = {
        # DDOS PROTECTION NOTE ##################################################
        Enable-DDoS-VNET = {
          enforcement_mode = "DoNotEnforce"
        }
        #######################################################################
      }
    }
    landingzones = {
      policy_assignments = {
        # DDOS PROTECTION NOTE ##################################################
        Enable-DDoS-VNET = {
          enforcement_mode = "DoNotEnforce"
        }
        #######################################################################
      }
    }
  }

  management_group_role_assignments = {
    #     vm_admin = {
    #     management_group_name      = "connectivity"
    #     role_definition_id_or_name = "Virtual Machine Administrator Login"
    #     principal_id               = "TO-BE-UPDATED"
    #     principal_type             = "Group"
    #   }
  }
}

management_resource_groups = {
  amba = {
    name     = "$${primary_amba_resource_group_name}"
    location = "$${starter_location_01}"
  }
}



/*
--- Custom Replacements ---
You can define custom replacements to use throughout the configuration.
*/
custom_replacements = {
  /* 
  --- Custom Name Replacements ---
  You can define custom names and other strings to use throughout the configuration. 
  You can only use the built in replacements in this section.
  NOTE: You cannot refer to another custom name in this variable.
  */
  names = {
    # Defender email security contact
    defender_email_security_contact = "" # TO-BE-UPDATED

    # Resource group names
    primary_management_resource_group_name       = "rg-management-$${starter_location_01}"
    primary_amba_resource_group_name             = "rg-amba-$${starter_location_01}"
    primary_connectivity_hub_resource_group_name = "rg-hub-$${starter_location_01}"
    dns_resource_group_name                      = "rg-hub-dns-$${starter_location_01}"

    # Management resources names
    primary_log_analytics_workspace_name            = "law-management-$${starter_location_01}"
    primary_automation_account_name                 = "aa-management-$${starter_location_01}"
    primary_ama_user_assigned_managed_identity_name = "uami-management-ama-$${starter_location_01}"
    primary_amba_user_assigned_managed_identity_name = "uami-amba-$${starter_location_01}"

    # Diagnostic settings names
    dcr_change_tracking_name = "dcr-change-tracking"
    dcr_defender_sql_name    = "dcr-defender-sql"
    dcr_vm_insights_name     = "dcr-vm-insights"

    # Resource names management
    primary_log_analytics_workspace_name = "law-management-$${starter_location_01}"

    # Resource names primary connectivity
    primary_virtual_network_name = "vnet-hub-$${starter_location_01}"

    # AZURE FIREWALL NVA NOTE: Use these variables to set the hub virtual network appliance configuration if deploying a hub and spoke virtual network topology with a hub virtual network appliance.
    primary_firewall_name                = "azfw-hub-$${starter_location_01}"
    primary_firewall_public_ip_name      = "pip-azfw-hub-$${starter_location_01}"
    primary_firewall_mgmt_public_ip_name = "pip-azfw-hub-mgmt-$${starter_location_01}"
    primary_firewall_policy_name         = "afp-hub-$${starter_location_01}"

    # ROUTE TABLE NOTE: If deploying route tables, use these variables to set the route table names and references
    primary_route_table_firewall_name     = "rt-hub-fw-$${starter_location_01}"
    primary_route_table_user_subnets_name = "rt-hub-std-$${starter_location_01}"
    # EXPRESS ROUTE & VPN NOTE: Use these variables if deploying express route or VPN gateways
    primary_gateway_subnet_route_table_name = "rt-gw-hub-$${starter_location_01}"
    primary_gateway_subnet_route_table_firewall_route_name = "rt-hub-gateway-fw-$${starter_location_01}"

    # EXPRESS ROUTE NOTE: Use these variables if deploying express route
    primary_express_route_resource_group_name = "rg-er-$${starter_location_01}"
    primary_virtual_network_gateway_express_route_name = "vgw-hub-er-$${starter_location_01}"
    primary_express_route_circuit_name                 = "erc-hub-$${starter_location_01}"
    primary_express_route_connection_name              = "cn-er-vng-$${starter_location_01}"

    # VPN NOTE: Use these variables if deploying VPN
    primary_virtual_network_gateway_vpn_name             = "vgw-hub-vpn-$${starter_location_01}"
    primary_virtual_network_gateway_vpn_public_ip_name_1 = "pip-vgw-hub-vpn-$${starter_location_01}-001"
    primary_virtual_network_gateway_vpn_public_ip_name_2 = "pip-vgw-hub-vpn-$${starter_location_01}-002"

    # Private DNS Zones primary
    primary_auto_registration_zone_name               = "$${starter_location_01}.azure.local"
    primary_private_dns_resolver_name                 = "pdr-hub-dns-$${starter_location_01}"
    primary_private_dns_resolver_inbound_subnet_name  = "InboundEndpointSubnet"
    primary_private_dns_resolver_outbound_subnet_name = "OutboundEndpointSubnet"

    # BASTION NOTE: Use these variables if deploying Bastion
    primary_bastion_host_name           = "bas-hub-$${starter_location_01}"
    primary_bastion_host_public_ip_name = "pip-bastion-hub-$${starter_location_01}"

    # DDOS PROTECTION NOTE: Use these variables if deploying DDoS Protection
    primary_ddos_protection_plan_name = "ddos-plan-$${starter_location_01}"

    # IP Ranges Primary
    # Regional Address Space: Think of allocating a /18 for your entire region
    # MULTI-REGION NOTE: For multi-region deployments, this is used in the Firewall UDR to send traffic within this address to the other regional hub appliance.
    primary_hub_address_space = "TO-BE-UPDATED" # recommended /18 This is the address space for the hub and spoke topology within an entire region.

    primary_hub_virtual_network_address_space = "TO-BE-UPDATED" # recommended /23
    # AZURE FIREWALL NOTE: Use these variables to set the hub virtual network appliance configuration if deploying a hub and spoke virtual network topology with a hub virtual network appliance. The firewall and management subnets should be at least /26 to accommodate the firewall and its scaling requirements.
    primary_az_firewall_subnet_address_prefix      = "TO-BE-UPDATED" # recommended /26
    primary_az_firewall_mgmt_subnet_address_prefix = "TO-BE-UPDATED" # recommended /26

    primary_gateway_subnet_address_prefix                       = "TO-BE-UPDATED" # recommended /26
    primary_bastion_subnet_address_prefix                       = "TO-BE-UPDATED" # recommended /26
    primary_private_dns_resolver_inbound_subnet_address_prefix  = "TO-BE-UPDATED" # recommended /28
    primary_private_dns_resolver_outbound_subnet_address_prefix = "TO-BE-UPDATED" # recommended /28



  }

  /* 
  --- Custom Resource Group Identifier Replacements ---
  You can define custom resource group identifiers to use throughout the configuration. 
  You can only use the templated variables and custom names in this section.
  NOTE: You cannot refer to another custom resource group identifier in this variable.
  */
  resource_group_identifiers = {
    primary_management_resource_group_id = "/subscriptions/$${subscription_id_management}/resourceGroups/$${primary_management_resource_group_name}"
    primary_amba_resource_group_id       = "/subscriptions/$${subscription_id_management}/resourceGroups/$${primary_amba_resource_group_name}"
    primary_hub_resource_group_id        = "/subscriptions/$${subscription_id_connectivity}/resourceGroups/$${primary_connectivity_hub_resource_group_name}"
    dns_resource_group_id                = "/subscriptions/$${subscription_id_connectivity}/resourceGroups/$${dns_resource_group_name}"
    # EXPRESS ROUTE NOTE: Use this variable to set the Express Route Circuit resource group ID reference. This is used in the virtual network gateway configuration.
    primary_express_route_resource_group_id = "/subscriptions/$${subscription_id_connectivity}/resourceGroups/$${primary_express_route_resource_group_name}"
  }

  /* 
  --- Custom Resource Identifier Replacements ---
  You can define custom resource identifiers to use throughout the configuration. 
  You can only use the templated variables, custom names and customer resource group identifiers in this variable.
  NOTE: You cannot refer to another custom resource identifier in this variable.
  */
  resource_identifiers = {
    primary_log_analytics_workspace_id              = "$${primary_management_resource_group_id}/providers/Microsoft.OperationalInsights/workspaces/$${primary_log_analytics_workspace_name}"
    primary_ama_change_tracking_data_collection_rule_id = "$${primary_management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_change_tracking_name}"
    primary_ama_mdfc_sql_data_collection_rule_id        = "$${primary_management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_defender_sql_name}"
    primary_ama_vm_insights_data_collection_rule_id     = "$${primary_management_resource_group_id}/providers/Microsoft.Insights/dataCollectionRules/$${dcr_vm_insights_name}"
    primary_ama_user_assigned_managed_identity_id       = "$${primary_management_resource_group_id}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/$${primary_ama_user_assigned_managed_identity_name}"
    # EXPRESS ROUTE NOTE: Use this variable to set the Express Route Circuit ID reference. This is used in the virtual network gateway configuration.
    primary_express_route_circuit_id = "$${primary_express_route_resource_group_id}/providers/Microsoft.Network/expressRouteCircuits/$${primary_express_route_circuit_name}"
    # DDOS PROTECTION PLAN NOTE: Use this variable to set the DDoS Protection Plan ID reference. This is used in the hub virtual network configuration if deploying DDoS Protection.
    primary_ddos_protection_plan_id = "$${primary_hub_resource_group_id}/providers/Microsoft.Network/ddosProtectionPlans/$${primary_ddos_protection_plan_name}"
  }
}

/*
--- Tags ---
This variable can be used to apply tags to all resources that support it. Some resources allow overriding these tags.
*/
tags = {
  deployed_by = "terraform"
  source      = "Azure Landing Zones Accelerator"
}

/* 
--- Connectivity - Hub and Spoke Virtual Network ---
You can use this section to customize the hub virtual networking that will be deployed.
*/
connectivity_type = "hub_and_spoke_vnet"

connectivity_resource_groups = {
  # MULTI-REGION NOTE: For multi-region deployments, you can specify different resource group names and locations for the hub virtual network resources. 
  vnet_primary = {
    name     = "$${primary_connectivity_hub_resource_group_name}"
    location = "$${starter_location_01}"
  }
  ##########################################################################
  dns = {
    name     = "$${dns_resource_group_name}"
    location = "$${starter_location_01}"
  }
}

hub_and_spoke_networks_settings = {
  enabled_resources = {
    # DDOS CONFIGURATION ##################################################
    ddos_protection_plan = false
    #######################################################################
  }
}

hub_virtual_networks = {
  primary = {
    enabled_resources = {
      # AZURE RESOURCES NOTE: The resources enabled in this section will be deployed in the hub virtual network resource group. 
      # You can enable or disable resources based on your needs, but be aware that some resources have dependencies on others (e.g. the firewall depends on the route tables). 
      # If you disable a resource that another resource depends on, you may need to update the configuration to remove references to the disabled resource.
      firewall_policy                       = true
      firewall                              = true
      virtual_network_gateway_express_route = false
      virtual_network_gateway_vpn           = false
      private_dns_resolver                  = true
      private_dns_zones                     = true
      bastion                               = true
    }
    location                  = "$${starter_location_01}"
    default_hub_address_space = "$${primary_hub_address_space}"
    default_parent_id         = "$${primary_hub_resource_group_id}"
    hub_virtual_network = {
      name                          = "$${primary_virtual_network_name}"
      parent_id                     = "$${primary_hub_resource_group_id}"
      location                      = "$${starter_location_01}"
      address_space                 = ["$${primary_hub_virtual_network_address_space}"]
      routing_address_space         = ["$${primary_hub_address_space}"]
      route_table_name_firewall     = "$${primary_route_table_firewall_name}"
      route_table_name_user_subnets = "$${primary_route_table_user_subnets_name}"
      # HUB NVA NOTE: Use these variables to set the hub NVA configuration if deploying a hub and spoke virtual network topology with a hub virtual network appliance. The hub router IP address is used in the spoke virtual network configurations to set the default route next hop.
      #   hub_router_ip_address         = "$${primary_nva_ip_address}"
      #   dns_servers = []
      # DDOS PROTECTION NOTE: Use this variable to set the DDoS Protection Plan configuration if deploying DDoS Protection.
      ddos_protection_plan_id = null # "$${primary_ddos_protection_plan_id}" # This should be the resource ID of an existing DDoS Protection Plan, if deploying DDoS Protection

      subnets = {
        dns_outbound = {
          name             = "$${primary_private_dns_resolver_outbound_subnet_name}"
          address_prefixes = ["$${primary_private_dns_resolver_outbound_subnet_address_prefix}"]
          route_table = {
            assign_generated_route_table = false
          }
          default_outbound_access_enabled = false
          delegations = [
            {
              name = "Microsoft.Network.dnsResolvers"
              service_delegation = {
                name = "Microsoft.Network/dnsResolvers"
              }
            }
          ]
        }

      }

    }

    firewall = {
      name                                              = "$${primary_firewall_name}"
      subnet_address_prefix                             = "$${primary_az_firewall_subnet_address_prefix}"
      subnet_default_outbound_access_enabled            = false
      management_ip_enabled                             = true
      management_subnet_address_prefix                  = "$${primary_az_firewall_mgmt_subnet_address_prefix}"
      management_subnet_default_outbound_access_enabled = false
      sku_name                                          = "AZFW_VNet"
      sku_tier                                          = "Standard"
      zones                                             = [1, 2, 3]
      ip_configurations = {
        default = {
          is_default = false
          name       = "FirewallConfigDefault" # This is the name of the firewall IP configuration, it can be used in the route tables to reference the firewall private IP as the next hop for traffic inspection.
          public_ip_config = {
            name     = "$${primary_firewall_public_ip_name}"
            sku_tier = "Regional" # Regional or Global
            zones    = [1, 2, 3]
          }
        }
      }
      management_ip_configuration = {
        public_ip_config = {
          name     = "$${primary_firewall_mgmt_public_ip_name}"
          sku_tier = "Regional" # Regional or Global
          zones    = [1, 2, 3]
        }
      }
    }

    firewall_policy = {
      name                              = "$${primary_firewall_policy_name}"
      sku                               = "Standard"
      auto_learn_private_ranges_enabled = false
      dns = {
        servers       = []
        proxy_enabled = false
      }
      insights = {
        default_log_analytics_workspace_id = "$${primary_log_analytics_workspace_id}"
        enabled                            = true
        retention_in_days                  = 90
      }
      intrusion_detection      = {}
      threat_intelligence_mode = "Alert"
      # threat_intelligence_allowlist = {
      #     ip_addresses = []
      #     fqdn         = []
      # }
      # AZURE FIREWALL POLICY NOTE: If you want to provide a parent policy with base rules, you can use the base_policy_id variable to reference the resource ID of an existing Azure Firewall Policy. The rules from the base policy will be inherited by the deployed firewall policy. You can then use the rule_overrides block to override specific rules from the base policy if needed.
      #base_policy_id = "/subscriptions/$${subscription_id_connectivity}/resourceGroups/$${primary_connectivity_hub_resource_group_name}/providers/Microsoft.Network/firewallPolicies/$${custom_firewall_policy_name}"

    }

    # virtual_network_gateways = {
    #   subnet_address_prefix = "$${primary_gateway_subnet_address_prefix}"

    #   route_table_bgp_route_propagation_enabled = true
    #   route_table_creation_enabled              = true
    #         route_table_gateway_firewall_route_enabled = true
    #   route_table_gateway_firewall_route_name    = "$${primary_gateway_subnet_route_table_firewall_route_name}"
    #   route_table_name                          = "$${primary_gateway_subnet_route_table_name}"
    #   route_table_custom_routes = {
    #     # custom_route_1 = {
    #     #   name                = "custom-route-example"
    #     #   address_prefix      = "192.168.0.0/24"
    #     #   next_hop_type       = "VirtualAppliance"
    #     #   next_hop_ip_address = "192.168.200.1"
    #     # }
    #   }
    #   # EXPRESS ROUTE NOTE: Use this block to configure the Express Route virtual network gateway settings if deploying Express Route connectivity. The express_route_circuits block is used to link the Express Route Circuit to the virtual network gateway and configure the connection settings. The peering block is used to configure the peering settings for the Express Route Circuit.
    #   # express_route = {
    #   #   parent_id                             = "$${primary_hub_resource_group_id}"
    #   #   name                                  = "$${primary_virtual_network_gateway_express_route_name}"
    #   #   sku                                   = "ErGw3AZ"
    #   #   express_route_remote_vnet_traffic_enabled = false
    #   #   hosted_on_behalf_of_public_ip_enabled = true
    #   #   # NOTE: To use this, set the hosted_on_behalf_of_public_ip_enabled to false. The ip_configurations block is not required for the virtual network gateway deployment, but if you want to use it, you can uncomment the block and provide the necessary variables. The public IP configuration in the ip_configurations block will override the default public IP configuration of the virtual network gateway.
    #   #   # ip_configurations = {
    #   #   #   default = {
    #   #   #     name = "vnetGatewayConfigdefault"
    #   #   #     public_ip = {
    #   #   #       name                    = "$${primary_virtual_network_gateway_express_route_public_ip_name}"
    #   #   #       zones                   = [1, 2, 3]
    #   #   #       creation_enabled        = true
    #   #   #       allocation_method       = "Static"   # Static or Dynamic
    #   #   #       sku                     = "Standard" # Standard or Basic
    #   #   #       sku_tier                = "Regional" # Regional or Global
    #   #   #       zones                   = [1, 2, 3]
    #   #   #       ddos_protection_mode    = "Enabled"
    #   #   #       ddos_protection_plan_id = null
    #   #   #     }
    #   #   #   }
    #   #   # }

    #   #   vpn_type = "RouteBased" # PolicyBased or RouteBased, ExpressRoute only supports RouteBased
    #   #   diagnostic_settings_virtual_network_gateway = {
    #   #     name                           = "diag-er-law-$${starter_location_01}"
    #   #     workspace_resource_id          = "$${primary_log_analytics_workspace_id}"
    #   #     log_analytics_destination_type = "Dedicated"
    #   #   }
    #   #   express_route_circuits = {
    #   #     primary = {
    #   #       id = "$${primary_express_route_circuit_id}" # The ID of the ExpressRoute Circuit that must already exist
    #   #       connection = {
    #   #         name                = "$${primary_express_route_connection_name}"
    #   #         resource_group_name = "$${primary_express_route_resource_group_name}"
    #   #         #shared_key                     = "$${express_route_circuit_shared_key}" # Should be stored in Key Vault, ALZ owner to provide to the ER provider
    #   #         express_route_gateway_bypass   = true
    #   #         private_link_fast_path_enabled = true
    #   #         routing_weight                 = 10
    #   #       }
    #   #       peering = {
    #   #         peering_type                  = "AzurePrivatePeering"
    #   #         vlan_id                       = 0 # VLAN ID must be number not string
    #   #         resource_group_name           = "$${primary_express_route_resource_group_name}"
    #   #         primary_peer_address_prefix   = "TO-BE-UPDATED" # recommended /30
    #   #         secondary_peer_address_prefix = "TO-BE-UPDATED" # recommended /30
    #   #         ipv4_enabled                  = true
    #   #         peer_asn                      = 0 # ASN must be number not string
    #   #       }
    #   #     }
    #   #   }
    #   # }
    #   # VPN NOTE: Use this block to configure the VPN virtual network gateway settings if deploying VPN connectivity. The ip_configurations block is used to configure the public IP settings for the virtual network gateway.
    #   # vpn = {
    #   #   parent_id                             = "$${primary_hub_resource_group_id}"
    #   #   name                                  = "$${primary_virtual_network_gateway_vpn_name}"
    #   #   vpn_bgp_enabled                       = false
    #   #   vpn_active_active_enabled           = true
    #   #   sku                                   = "VpnGw2"
    #   #   vpn_type                              = "RouteBased" # PolicyBased or RouteBased
    #   #   ip_configurations = {
    #   #     active_active_1 = {
    #   #       name = "vnetGatewayConfigdefault"
    #   #       public_ip = {
    #   #         name                    = "$${primary_virtual_network_gateway_vpn_public_ip_name_1}"
    #   #         zones                   = [1, 2, 3]
    #   #         creation_enabled        = true
    #   #         allocation_method       = "Static"   # Static or Dynamic
    #   #         sku                     = "Standard" # Standard or Basic
    #   #         sku_tier                = "Regional" # Regional or Global
    #   #         zones                   = [1, 2, 3]
    #   #         # DDOS PROTECTION NOTE: Use the ddos_protection_mode and ddos_protection_plan_id to configure DDoS Protection for the virtual network gateway public IPs if deploying DDoS Protection. The ddos_protection_plan_id should be the resource ID of an existing DDoS Protection Plan.
    #   #         ddos_protection_mode    = "Enabled"
    #   #         ddos_protection_plan_id = null
    #   #       }
    #   #     }
    #   #     active_active_2 = {
    #   #       name = "vnetGatewayConfigSecondary"
    #   #       public_ip = {
    #   #         name                    = "$${primary_virtual_network_gateway_vpn_public_ip_name_2}"
    #   #         zones                   = [1, 2, 3]
    #   #         creation_enabled        = true
    #   #         allocation_method       = "Static"   # Static or Dynamic
    #   #         sku                     = "Standard" # Standard or Basic
    #   #         sku_tier                = "Regional" # Regional or Global
    #   #         zones                   = [1, 2, 3]
    #   #         # DDOS PROTECTION NOTE: Use the ddos_protection_mode and ddos_protection_plan_id to configure DDoS Protection for the virtual network gateway public IPs if deploying DDoS Protection. The ddos_protection_plan_id should be the resource ID of an existing DDoS Protection Plan.
    #   #         ddos_protection_mode    = "Enabled"
    #   #         ddos_protection_plan_id = null
    #   #       }
    #   #     }
    #   #   }
    #   #   local_network_gateways = {
    #   #     default = {
    #   #       name                = "lngw-onpremises-001"
    #   #       resource_group_name = "$${primary_connectivity_hub_resource_group_name}"
    #   #       gateway_ip_address  = "TO-BE-UPDATED" # This is the public IP address of the on-premises VPN device that will be connecting to the virtual network gateway.
    #   #       gateway_fqdn         = null # This is the fully qualified domain name of the on-premises VPN device that will be connecting to the virtual network gateway. This is an optional parameter, but if provided, it will be used instead of the gateway_ip_address for the connection configuration.
    #   #       local_network_address_space = ["TO-BE-UPDATED"] # This is the address space of the on-premises network that will be connecting to the virtual network gateway.
    #   #       connection = {
    #   #           name                = "cn-lngw-$${starter_location_01}-to-onpremises-001"
    #   #           resource_group_name = "$${primary_connectivity_hub_resource_group_name}"
    #   #           connection_mode = "Default" # Default or ExpressRoute
    #   #           type = "IPsec" # IPsec or Vnet2Vnet
    #   #           connection_protocol = "IKEv2" # IKEv2 or IKEv1
    #   #           dpd_timeout_seconds = 45
    #   #           enable_bgp                     = false
    #   #           local_azure_ip_address_enabled = false
    #   #           routing_weight                 = 10
    #   #       }
    #   #     }
    #   #   }
    #   # }
    # }

    private_dns_resolver = {
      name                                   = "$${primary_private_dns_resolver_name}"
      subnet_name                            = "$${primary_private_dns_resolver_inbound_subnet_name}"
      subnet_default_outbound_access_enabled = false
      subnet_address_prefix                  = "$${primary_private_dns_resolver_inbound_subnet_address_prefix}"
      # This is only needed for additional inbound endpoints beyond the default one, which gets created in the specified subnet and assigned the .4 IP address of that subnet. If you only need the default inbound endpoint, you can leave this block empty.
      # inbound_endpoints = {
      #   alternate = {
      #     name                         = "dns-default-inbound-endpoint"
      #     subnet_name                  = "$${primary_private_dns_resolver_inbound_subnet_name}"
      #     private_ip_allocation_method = "Static"        # Static or Dynamic, for predictable IP address assignment, use Static and specify the private_ip_address. For automatic IP address assignment, use Dynamic and do not specify the private_ip_address.
      #     private_ip_address           = "TO-BE-UPDATED" # This should be an available IP address within the private DNS resolver inbound subnet address prefix, should not be the .4 IP since the default inbound endpoint gets assigned to that IP.
      #   }
      # }
      outbound_endpoints = {
        default = {
          name        = "dns-default-outbound-endpoint"
          subnet_name = "$${primary_private_dns_resolver_outbound_subnet_name}"
          forwarding_ruleset = {
            default = {
              name                                        = "fwd-ruleset1"
              link_with_outbound_endpoint_virtual_network = true
              additionalVirtualNetworkLinks               = {}
              rules = {
                default = {
                  name        = "campus-domain-rule"
                  enabled     = true
                  domain_name = "TO-BE-UPDATED" # This should be the domain name for which you want to forward DNS queries to the on-premises DNS server, e.g. "contoso.com". You can specify multiple rules for different domain names if needed.
                  destination_ip_addresses = {
                    "X.X.X.X" = "53" # TO-BE-UPDATED: This should be the IP address and port of the on-premises DNS server that will be used for forwarding queries for the specified domain name. You can specify multiple destination IP addresses if you have multiple on-premises DNS servers for redundancy.
                  }
                }
              }
            }
          }
        }
      }
    }

    private_dns_zones = {
      auto_registration_zone_enabled   = true
      auto_registration_zone_name      = "$${primary_auto_registration_zone_name}"
      auto_registration_zone_parent_id = "$${dns_resource_group_id}"
      parent_id                        = "$${dns_resource_group_id}"

      virtual_network_link_overrides_by_zone = {
        azure_data_factory_portal = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_power_bi_tenant_analysis = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_power_bi_dedicated = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_power_bi_power_query = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_fabric = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_avd_global = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_avd_feed_mgmt = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_arc_hybrid_compute = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_arc_guest_configuration = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_backup = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_site_recovery = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_monitor = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_log_analytics = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_log_analytics_data = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_monitor_agent = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_purview_account = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_purview_studio = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_purview_service = {
          resolution_policy = "NxDomainRedirect"
        }
        azure_synapse_dev = {
          resolution_policy = "NxDomainRedirect"
        }
      }
    }

    bastion = {
      subnet_address_prefix                  = "$${primary_bastion_subnet_address_prefix}"
      subnet_default_outbound_access_enabled = false
      name                                   = "$${primary_bastion_host_name}"
      copy_paste_enabled                     = false
      file_copy_enabled                      = false
      zones                                  = [1, 2, 3]
      sku                                    = "Standard"

      bastion_public_ip = {
        name  = "$${primary_bastion_host_public_ip_name}"
        zones = [1, 2, 3]
        # DDOS PROTECTION NOTE: Use the ddos_protection_mode and ddos_protection_plan_id to configure DDoS Protection for the Bastion host public IP if deploying DDoS Protection. The ddos_protection_plan_id should be the resource ID of an existing DDoS Protection Plan.
        ddos_protection_mode    = "Enabled"
        ddos_protection_plan_id = null # "$${primary_ddos_protection_plan_id}" # This should be the resource ID of an existing DDoS Protection Plan, if deploying DDoS Protection
      }
    }
  }
}