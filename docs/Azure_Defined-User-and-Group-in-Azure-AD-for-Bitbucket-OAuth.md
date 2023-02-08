# Azure - Defined User and Group in Azure AD for Bitbucket OAuth

Ensured that I had the `Demo AD` Tenant active (next to my name in the corner)

Opened the **Azure Active Directory** service inside the Azure Portal

Clicked **Groups** in the left panel, then clicked **New Group**

Entered the following and clicked **Create**:

* **Group type**: `Security`
* **Group name**: `stash-users`
    * NOTE: This is the default user group in Bitbucket
* **Group description**: (blank)

**TODO**: Does the group membership matter if the user is already in the group in Bitbucket?
I believe I created this AD group when I was experimenting with JIT User Provioning in Bitbucket.

Clicked **Users** in the left panel, then clicked **New User**, then clicked **Create new user**

Entered the following and clicked **Create**:

* **Email address**: `first.user` @ `ryankenneymildemo.onmicrosoft.com`
* **Name**: `First User`
* **First name**: `First`
* **Last name**: `User`
* **Password**:
    * `[✓]` **Auto-generate password**
    * NOTE: Saved a copy of the auto-generated password before continuing (clicked **Show Password**)
* **Groups**: (added to `stash-users`)

For some reason the **Properties** tab for the new user has a blank **Email** field,
so I manually set it to `first.user@ryankenneymildemo.onmicrosoft.com` with the **Edit Properties** button.

* **TODO**: Was this necessary?
