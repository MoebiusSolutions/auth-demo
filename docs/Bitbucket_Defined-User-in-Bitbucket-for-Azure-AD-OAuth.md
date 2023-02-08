# Bitbucket - Defined User in Bitbucket for Azure AD OAuth

In Bitbucket, opened **Administration** (gear icon)

Clicked **Users** in the left panel, then clicked **Create user**

Entered the following and then clicked **Create user**:

* **Username**: `first.user@ryankenneymildemo.onmicrosoft.com`
    * NOTE: This must match the field being used as **Username mapping**
      in the **Authentication Method** we defined in Bitbucket
* **Full name**: `First User`
* **Email address**: `first.user@ryankenneymildemo.onmicrosoft.com`
* **Password**: (A password unrelated to the Azure AD user password. We effectively never use this password.)

NOTE: The user is automatically added to the `stash-users` group.
