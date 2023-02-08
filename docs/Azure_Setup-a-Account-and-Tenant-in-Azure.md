# Azure - Setup a Account and Tenant in Azure

## Created Azure Account

I created a new, personal (not associated with a company or school) account on `portal.azure.com`

* I ended up having to run through the signup process twice to get Azure Active Directory to load in the portal.
    * After the first time through I kept getting a `No access` error
    * The second time through running through Azure setup, I was prompted for a credit card
      (but it is still explicitly not billing me)

## Defined/Activated a "Demo AD" Tenant

Opened the **Azure Active Directory** service inside the Azure Portal

Clicked **Manage Tenants**

Clicked **Create** and created a Tenant with the following options:

* **Basics**
    * **Select a tenant type**: `Azure Active Directory`
* **Configuration**
    * **Organization name**: `Demo AD`
    * **Initial domain name**: `ryankenneymildemo` (which translates to `ryankenneymildemo.onmicrosoft.com`)
    * **Country/Region**: `United States`

Activated the Tenant:
 
* Clicked on my name in the top-right corner, then **Switch directory**, then the **Switch** button next to `Demo AD`
