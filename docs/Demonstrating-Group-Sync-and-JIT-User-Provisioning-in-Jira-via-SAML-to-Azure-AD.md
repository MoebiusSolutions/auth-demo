# Demonstrating Group Sync and JIT User Provisioning in Jira via SAML to Azure AD

## Overview

This is very similar to
[Demonstrating Group Sync and JIT User Provisioning in Bitbucket via SAML to Azure AD](Demonstrating-Group-Sync-and-JIT-User-Provisioning-in-Bitbucket-via-SAML-to-Azure-AD.md),
so I am only covering only the aspects that differ from that procedure.

## Setup Standard Users and Groups in Azure AD

[Define Standard Users and Groups in Azure AD](Azure_Define-Standard-Users-and-Groups-in-Azure-AD.md)

## Defined Groups in Jira

In Jira, clicked **Administration** (gear icon), then **User Management**, then **Groups** in the left panel

Used **Add group** to add the UUID (not the group name) of each of the following groups from Azure AD:

* `jira-users`
* `projecta-read`
* `projecta-write`
* `projecta-admin`
* `projectb-read`
* `projectb-write`
* `projectb-admin`
* `projectc-read`
* `projectc-write`
* `projectc-admin`

## Granted `jira-users` Group Access to Jira

In Jira, clicked **Administration** (gear icon), then **System**, then **Global permissions** in the left panel

## Defined Reader Role in Jira

In Jira, I clicked **Administration** (gear icon), then **System**, then **Project roles** in the left panel

Added a role:

* Name: `Reader`
* Description: `Users with read access to the project`

## Granted Reader Role Default Permissions in Jira

In Jira, clicked **Administration** (gear icon), then **Issues**, then **Permission schemes** in the left panel

Clicked **Permissions** next to **Default software scheme**

Clicked the **Grant permission** button

Entered the following and clicked **Grant**:

* Permission: `Browse Projects`
* Granted to: `Project Role`: `Reader`

Clicked the **Remove** button in the **Browse Projects** row

* Checked only the **Application access - Any logged in user** line and clicked **Remove**

## Created Projects in Jira

In Jira, clicked **Administration** (gear icon), then **Projects**

Clicked **Create project**, then **Basic software project** repeatedly to create the following projects:

* **Name**: `Project A`
    * **Key**: `PROJA`
* **Name**: `Project B`
    * **Key**: `PROJB`
* **Name**: `Project C`
    * **Key**: `PROJC`

## Associated User Groups with Project Roles in Jira

In Jira, clicked **Administration** (gear icon), then **Projects**

For each project, I clicked on the project name, then:

* Clicked **Users and Roles** in the left panel
* Clicked **Add users to a role** button repeatedly to define the following entries:
    * The `projectX-admin` group (which is actually a UUID) associated with the `Administrators` Role
    * The `projectX-reader` group (which is actually a UUID) associated with the `Reader` Role

## Verified Login/Permissions

I was able to use the `Demo Azure SAML SSO` button to login to Artifactory as `first.user`

When I clicked **Projects**, then **View All Projects**, I saw Project A and Project C, but not Project B

When I viewed Project A and Project C, only Project A had the
Administration (gear icon) button available in the lower right

