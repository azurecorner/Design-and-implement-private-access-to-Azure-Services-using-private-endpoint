# Design-and-implement-private-access-to-Azure-Services-using-private-endpoint


![architecture](https://github.com/azurecorner/Design-and-implement-private-access-to-Azure-Services-using-private-endpoint/assets/108787059/0bc8ce0b-93a3-4a83-99ff-4dfe454f7734)

Workflow
The web app receives an HTTP request from the internet that requires an API call to the Azure SQL Database.

By default, web apps hosted in App Service can reach only internet-hosted endpoints. To communicate with the resources in your virtual network that aren't internet facing, you need to enable regional virtual network integration. Region virtual network integration gives the web app access to resources in the virtual network that aren't internet-hosted endpoint. Regional network integration mounts a virtual interface in the AppSvcSubnet that the App Service web app connects to.

The web app connects to the virtual network through a virtual interface mounted in the AppSvcSubnet of the virtual network.

Azure Private Link sets up a private endpoint for the Azure SQL Database in the PrivateLinkSubnet of the virtual network.

The web app sends a query for the IP address of the Azure SQL Database. The query traverses the virtual interface in the AppSvcSubnet. The CNAME of the Azure SQL Database directs the query to the private DNS zone. The private DNS zone returns the private IP address of the private endpoint set up for the Azure SQL Database.

The web app connects to the Azure SQL Database through the private endpoint in the PrivateLinkSubnet.

The Azure SQL Database firewall allows only traffic coming from the PrivateLinkSubnet to connect. The database is inaccessible from the public internet.

Components
This scenario uses the following Azure services:

Azure App Service hosts web applications, allowing autoscale and high availability without having to manage infrastructure.

Azure SQL Database is a general-purpose relational database managed service that supports relational data, spatial data, JSON, and XML.

Azure Virtual Network is the fundamental building block for private networks in Azure. Azure resources like virtual machines (VMs) can securely communicate with each other, the internet, and on-premises networks through Virtual Networks.

Azure Private Link provides a private endpoint in a Virtual Network for connectivity to Azure PaaS services like Azure Storage and SQL Database, or to customer or partner services.

Azure DNS hosts private DNS zones that provide a reliable, secure DNS service to manage and resolve domain names in a virtual network without the need to add a custom DNS solution.

az login 


 $ARM_SUBSCRIPTION_ID="023b2039-5c23-44b8-844e-c002f8ed431d"


az account set --subscription $ARM_SUBSCRIPTION_ID

az account show

$location  ="westeurope"
az deployment sub validate  `
--location $location  `
--name "irpsandbox"  `
--template-file main.bicep `
--parameters location=$location 




$location  ="westeurope"
az deployment sub  what-if  `
--location $location  `
--name "irpsandbox"  `
--template-file main.bicep `
--parameters location=$location 



$location  ="westeurope"
az deployment sub create `
--location $location  `
--name "irpsandbox"  `
--template-file main.bicep `
--parameters location=$location 



  git config --global user.email "leyegora@yahoo.fr"
  git config --global user.name "azurecorner"
