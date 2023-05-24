# Design-and-implement-private-access-to-Azure-Services-using-private-endpoint


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