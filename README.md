# Design-and-implement-private-access-to-Azure-Services-using-private-endpoint
A private endpoint is a network interface that uses a private IP address from your virtual network. This network interface connects you privately and securely to a service that's powered by Azure Private Link. By enabling a private endpoint, you're bringing the service into your virtual network.

https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview

Azure Private Link enables you to access Azure PaaS Services (for example, Azure Storage and SQL Database) and Azure hosted customer-owned/partner services over a private endpoint in your virtual network.

Traffic between your virtual network and the service travels the Microsoft backbone network. Exposing your service to the public internet is no longer necessary. You can create your own private link service in your virtual network and deliver it to your customers. Setup and consumption using Azure Private Link is consistent across Azure PaaS, customer-owned, and shared partner services.

![architecture](https://github.com/azurecorner/Design-and-implement-private-access-to-Azure-Services-using-private-endpoint/assets/108787059/0bc8ce0b-93a3-4a83-99ff-4dfe454f7734)

# Workflow
The web app receives an HTTP request from the internet that requires an API call to the Azure SQL Database.

Azure Bastion is a service you deploy that lets you connect to a virtual machine using your browser and the Azure portal
Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network in which it is provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

The virtual machine  connects to the virtual network through a virtual interface mounted in the ManagementSubnet of the virtual network.

Azure Private Link sets up a private endpoint for the Azure  Keyvault in the PrivateLinkSubnet of the virtual network.

The virtual machine sends a query for the IP address of the Azure Keyvault. The query traverses the virtual interface in the ManagementSubnet. The CNAME of the Azure Keyvault directs the query to the private DNS zone. The private DNS zone returns the private IP address of the private endpoint set up for the Azure Keyvault.

The virtual machine connects to the Azure Keyvault through the private endpoint in the PrivateLinkSubnet.

The Azure Keyvault firewall allows only traffic coming from the PrivateLinkSubnet to connect. The Keyvault is inaccessible from the public internet.

# Components
This scenario uses the following Azure services:

* Azure Virtual machine
* Azure Bastion host
* Azure Keyvault
* Azure Virtual Network
* Azure Private Link provides a private endpoint in a Virtual Network for connectivity to Azure PaaS services like Azure Storage and SQL Database, or to customer or partner services.
* Azure DNS hosts private DNS zones that provide a reliable, secure DNS service to manage and resolve domain names in a virtual network without the need to add a custom DNS solution.

# Deployment

###  ** Login to azure using your personal account or a service principal**

az login 


 $ARM_SUBSCRIPTION_ID="023b2039-5c23-44b8-844e-c002f8ed431d"


az account set --subscription $ARM_SUBSCRIPTION_ID

az account show

###  ** Validate the deployment **

$location  ="westeurope"
az deployment sub validate  `
--location $location  `
--name "irpsandbox"  `
--template-file main.bicep `
--parameters location=$location 

###  ** Preview the deployment **


$location  ="westeurope"
az deployment sub  what-if  `
--location $location  `
--name "irpsandbox"  `
--template-file main.bicep `
--parameters location=$location 

###  ** Perform the deployment **

$location  ="westeurope"
az deployment sub create `
--location $location  `
--name "irpsandbox"  `
--template-file main.bicep `
--parameters location=$location 

###  ** Test the deployment **


  git config --global user.email "leyegora@yahoo.fr"
  git config --global user.name "azurecorner"
