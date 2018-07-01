# Terraform Notes

## What is it?
* Terraform is "Software as Infrastructure"
  * Build, change, and version your infrastructure on the fly using software configurations

## How does it work?
1. Infrastructure as Code
  * High-level _reusable_ configuration syntax that describes your infrastructure
2. Execution Plans
  * Planning step where it generates an **Execution Plan**
    * Shows you what Terraform will do when you hit "apply"
    * Avoids any surprises
3. Resource Graph
  * Builds a graph of all your resources
  * Parallelizes the creation of non-dependent resources
4. Change Automation
  * The above all makes changing your Terraform configuration simple and easy
  * You know what Terraform will do with the changes immediately

## Use Cases
* Heroku App Setup
* Multi-Tier Applications
* Self-Service Clusters
* Software Demos
* Disposable Environments
* Software Defined Networking (SDN)
* Resource Schedulers
* Multi-Cloud Deployment


## Terminology
---
### Terraform Variables
#### Input Variables
There are 4 ways to define variables set in a `variables.tf` file:
1. **Command-Line Flags:**  Using `-var 'var_name=VALUE'` for each variable that isn't defaulted
2. **From a File:**  Define a `terraform.tfvars` file, or a name that matches `*.auto.tfvars`.  Use the file in the `terraform apply` command with `-var-file='terraform.tfvars'`.  In that file:
```
first_variable = "foo"
other_variable = "bar"
```
3. **Environment Variables:**  If you preface an environment variable with `TF_VAR_<varname>`, such as `TF_VAR_access_key`, Terraform will pick these up immediately.
4. **CLI Input:**  If you perform `terraform apply` with some variables not set, an interactive prompt will ask you for their values.
#### Output Variables
Output variables can send information that Terraform stores _back_ to the Terraform user, filtering on what information the user actually cares about.
* This data is output when `terraform apply`, but can be queried later using `terraform output <varname>`.
---
### Provisioners
Provisioners are used to configure infrastructure before it is initialized by Terraform.
Things like running shell scripts, installing software, configuration management scripts, etc.
are all setup using a Provisioner.  If you use image-based infrastructure, Provisioners are
not necessary, since all the configuration is handled by the image creation.  Provisioners are
only run when the associated resource is _created_.  Provisioners are meant as a method of
bootstrapping a server, not as a method for long-term configuration management.
##### What if a Provisioner Fails?
If a Provisioner fails even if the rest of the startup succeeds, the resource the Provisioner
failed on is labeled as "Tainted".  On next execution of a plan, the Terraform _destroys_ any
"Tainted" resources instead of attempting to re-run the Provisioner, since the resource
may no longer be safe.
* **Note**:  You can also define Provisioners that _only_ run during the `destroy` operation - this
is useful for system cleanup, etc.
---
### Modules
Modules are similar to Docker instances on the DockerHub - These are stored or registered configuration files that have predefined variables that are needed to be passed into the module when it is requested.  `terraform init` is required to obtain and download the module file from the Terraform Registry.
