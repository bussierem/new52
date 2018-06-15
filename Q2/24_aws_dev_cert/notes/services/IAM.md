# Identity Access Management (IAM)

## What is it?
* IAM allows you to manage users and their level of access to the AWS Console
* Grants:
  * Centralized control
  * Shared Access
  * Granular Permissions
  * Identity Federation (AD, Facebook, LinkedIn, etc)
  * 2FA
  * Provide Temporary Access to users/devices and services where necessary
  * Setup/manage password rotation
  * Integrates with other services
  * PCI DSS Compliance

---

### Terminology
* **Users:** End users
* **Groups:** A collection of users under one set of permissions
* **Roles:** Create roles and assign them to AWS resources
* **Policy:** Document that defines one or more permissions (applicable to Users, Groups, or Roles)
* **ARN:** Amazon Resource Name
---

### Important Info from the first Lab Exercise:
* "Access Key ID": API key for accessing AWS programmatically
* "Secret access key":  Private key for accessing AWS programmatically
  * Both of these can ONLY be used to access AWS programmatically

---

### Active Directory Federation
**This could come up in the exam!!!**
1. Bob browses to ADFS site inside his domain
2. Sign-on page authenticates Bob against AD, Bob enters user/pass
3. Bob's browser receives a SAML assertion in the form of an auth respons from ADFS
4. Bob's browser posts the SAML assertion to the AWS sign-in endpoint for SAML
  * Sign-in uses AssumeRoleWithSAML API to get temp creds
  * Constructs a sing-in URL for the AWS Console
5. Bob's browser receives the URL and is redirected to the console
**To Bob, he just logged into AWS Console using his AD credentials, no AWS credentials needed!**

#### Takeaways:
1. **Can you authenticate using the Active Directory?**  Yes, using SAML!
2. **Are you authenticating vs. AD first to get temp creds, or do you use temp creds to authenticate vs. AD?**  You authenticate against AD first, every time!

---
---

# Security Token Services (STS)

## What is it?
* STS grants Users limited and temporary access to AWS resources.  Users can come from 3 sources:
  1. **Federation (usually Active Directory)**
    * Uses SAML _(Security Assertion Markup Language)_
    * Grants temporary access based off the user's Active Directory credentials
      * User does not need to be an IAM "User"
    * Single sign-on allows users to login to AWS consoles without assigning IAM credentials
  2. **Federation w/ Mobile Apps**
    * Use Facebook/Amazon/Google or other OpenID providers
  3. **Cross-Account Access**
    * Lets users from one AWS account access resources in another

### Terminology
* **Federation:** Combining or joining users in one domain with users in another domain
* **Identity Broker:** A service that allows you to take an identity from point A and join it to point B
* **Identity Store:** AD, Facebook, Google, etc.
* **Identities:** Users of a service like Google, etc.

### Scenario 1:
You are hosting a company website on some EC2 web servers in your VPC. Users of the website must login to
the site which then authenticates against the company's active directory servers, which are based at
the company's headquarters.  Your VPC is connected to your company HQ via a secure IPSEC VPN.
Once logged in, the user can only have access to their own S3 bucket.

**How do you set this up?**
```
                +-----------+
                |           |
                | Employees |
                |           |
                +-----+-----+
                      |          
                      v
+----------------------------------------------+
|                                              |
|      Enterprise Reporting Application        |
|                                              |
+--+-------------------------------------+-----+
   |    ^                                |
 2 |    |                                |
   |    |  6                             |
   v    |                                |
+-------+--+      +----------------+     |
|          |      |                |     |
| Identity | <--> | LDAP Directory |     | 7
| Broker   |  3   |                |     |
|          |      +----------------+     |
+--+-------+                             |
   |     ^                               |
 4 |     | 5                             |
   v     |                               v
+--------+------+ +---------+    8  +-----------+
|               | |         | <-----+           |
| AWS Security  | | AWS IAM |       | Amazon S3 |
| Token Service | |         +-----> | Instance  |
|               | +---------+  9    |           |
+---------------+                   +-----------+
```

1. Employee enters username/password
2. Application calls an Identity Broker, which captures user/pass
3. Identity Broker uses the organization's LDAP directory to validate the employee's credentials
4. The Identity Broker calls the new GetFederationToken function in IAM credentials.
  * This call must include an IAM policy and a duration (1-36 hours), along with a policy that specifies the permissions to be granted to the temporary credentials
5. The Security Token Service confirms that the policy of the IAM user making the call gives permission to create new tokens, then returns 4 things to the application:
  * Access Key
  * Secret Access Key
  * Token
  * Duration (the Token's lifetime)
6. The Identity Broker returns the temporary credentials to the application
7. The data storage application uses the temporary credentials to make requests to Amazon S3
8. Amazon S3 uses IAM to verify that the credentials allow the requested operation on the given S3 Bucket and key
9. IAM provides S3 with the go-ahead to perform the requested operation

#### For the Exam:
1. Develop an Identity Broker to communicate with LDAP and AWS STS
2. Identity Broker always authenticates with LDAP first, THEN with AWS STS
3. Application then gets **temporary** access to AWS resources

### Scenario 2:
1. Develop an Identity Broker to communicate with LDAP and AWS STS
2. Identity Broker always authenticates with LDAP first, THEN gets an IAM Role associated with a user
3. Application then authenticates with STS and assumes that IAM Role
3. Application uses that IAM Role to interact with S3
