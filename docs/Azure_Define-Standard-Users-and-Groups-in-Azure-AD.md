# Azure - Define Standard Users and Groups in Azure AD

## Overview

I used the following user/group configuration during my testing.
This standardized setup allows us to easily confirm expected behaviors
instead of defining user configs in each setup procedure.


## Users/Groups Config

I created the following Security Groups at in the `Demo AD` Tenant:

* Groups that grant basic access to specific services:

    * `jira-users`: Grants basic access to Jira
    * `stash-users`: Grants basic access to Bitbucket

* Groups that simulate project-specific access 

    * `projecta-read`
    * `projecta-write`
    * `projecta-admin`
    * `projectb-read`
    * `projectb-write`
    * `projectb-admin`

Created the following sample users in the `Demo AD` Tenant:

* `First User` (`first.user@<domain>.onmicrosoft.com`)
* `Second User` (`first.user@<domain>.onmicrosoft.com`)

Add the sample users to these groups:

* `first.user`:
    * `jira-users`
    * `stash-users`
    * `projecta-read`
    * `projecta-write`
    * `projecta-admin`
    * (no membership in projectb)
    * `projectc-read`

