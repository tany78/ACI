terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "2.1.0"
    }
  }
}

provider "aci" {
		# cisco-aci user name
		username = "{var.username}"
		# cisco-aci user password
		password = "{var.password}"
		# cisco-aci private key
		#private_key = "{var.key_path}"
        # cisco-aci User Cert
		#cert_name = "{var.cert_name}"
		# cisco-aci url
		url      =  "{var.apic_url}"
		  insecure = true
}

resource "aci_tenant" "terraform_tenant" {
  name        = "TenantTerraform"   
  description = "This tenant is created by the Terraform ACI provider"
}

resource "aci_bridge_domain" "bd_for_subnet" {
  tenant_dn   = "{aci_tenant.terraform_tenant.id}"
  name        = "bd_for_subnet"
  description = "This bridge domain is created by the Terraform ACI provider"
}

resource "aci_subnet" "demosubnet" {
  parent_dn                           = "{aci_bridge_domain.bd_for_subnet.id}"
  ip                                  = "10.1.1.1/24"
  scope                               = ["private"]
  description                         = "This subnet is created by Terraform"
} 

