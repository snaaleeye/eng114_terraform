![terraform_pic](https://user-images.githubusercontent.com/105854053/176681612-fad1abd6-8066-44b6-b510-13fbf335f367.png)

## What is Terraform?

Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. 

You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

## Why should we use Terraform?

**1. Open source**

- Terraform is backed by large communities of contributors who build plugins to the platform. 
- Regardless of which cloud provider you use, it’s easy to find plugins, extensions, and professional support. 
- This also means Terraform evolves quickly, with new benefits and improvements added consistently.

**2. Platform agnostic** 

- Meaning you can use it with any cloud services provider. Most other IaC tools are designed to work with single cloud provider.

**3. Immutable infrastructure**

- Most Infrastructure as Code tools create mutable infrastructure, meaning the infrastructure can change to accommodate changes such as a middleware upgrade or new storage server. 

- The danger with mutable infrastructure is configuration drift—as the changes pile up, the actual provisioning of different servers or other infrastructure elements ‘drifts’ further from the original configuration, making bugs or performance issues difficult to diagnose and correct. 

- Terraform provisions immutable infrastructure, which means that with each change to the environment, the current configuration is replaced with a new one that accounts for the change, and the infrastructure is reprovisioned. Even better, previous configurations can be retained as versions to enable rollbacks if necessary or desired.

https://www.ibm.com/cloud/learn/terraform#:~:text=Terraform%20is%20an%20open%20source,%E2%80%9D%20tool%2C%20created%20by%20HashiCorp.

## What are the benefits of using Terraform?

**1. Improve multi-cloud infrastructure deployment**

- Terraform applies to multi-cloud scenarios, where similar infrastructure is deployed on cloud providers, or local data centers. Developers can use the same tool and configuration file to simultaneously manage the resources of different cloud providers.

**2. Automated infrastructure management**

- Terraform can create configuration file templates to define, provision, and configure ECS resources in a repeatable and predictable manner, reducing deployment and management errors resulting from human intervention. 
- In addition, Terraform can deploy the same template multiple times to create the same development, test, and production environment.

**3. Infrastructure as code**

- With Terraform, you can use code to manage and maintain resources. 
- It allows you to store the infrastructure status, so that you can track the changes in different components of the system (infrastructure as code) and share these configurations with others.

**4. Reduced development costs**

You can reduce costs by creating on-demand development and deployment environments. In addition, you can evaluate such environments before making system changes.

**5. Reduced time to provision**

Traditional click-ops methods of deployment used by organizations can take days or even weeks, in addition to being error-prone. With Terraform, full deployment can take just minutes. For example, you can provision multiple Alibaba Cloud services at a time in a standardized way. Both brand new deployments and migrations can be done quickly and efficiently.

**Uses cases for Terraform**

a) You need to automate the orchestration of a large number of resources.

b) You have developer resources to support the development of Terraform code.

c) You need to scale up and down the infrastructure according to variable online workloads.

d) You need to deploy a large system that involves a complex topology.

e) You need to apply repeated, clearly defined procedures on cloud resources.

f) You need to perform orchestration on a large heterogeneous system that involves multi-cloud and hybrid cloud platforms.

https://www.alibabacloud.com/blog/five-reasons-why-your-business-should-use-terraform-to-deploy-on-the-cloud_596342

## Who owns Terraform?

Terraform is an open source “Infrastructure as Code” tool, created by HashiCorp.

## Launch a server on AWS using Terraform

Step 1: Install/Set up Terraform 

Step 2: Set up environment variables 

AWS_ACCESS_KEY_ID= 123
AWS_SECRET_ACCESS_KEY= abc

Step 3: Create a new directory called terraform and create main.tf to launch an instance. 


```

# launch a server on aws

# who is the cloud provider AWS
provider "aws" {

# where do you ant to create resources eu-west-1
  region = "eu-west-1"

}

# what type of server - ubuntu 18.04 LTS ami
resource "aws_instance" "app_instance" {


#size of the server t2-micro
  ami = "ami-0b47105e3d7fc023e"
  instance_type = "t2.micro"
  key_name= "eng114_sharmake"
# do we need it to have a public access
  associate_public_ip_address = true


# what do we want to name it
  tags = {
      Name = "eng114_sharmake_terraform_app"
 }
}


```

Step 4: Run Terraform commands

`terraform init` - Initialises 

`terraform plan` -  lets you preview the changes that Terraform plans to make to your infrastructure.

`terraform apply` - executes the actions proposed in a Terraform plan.

`terraform destroy` - destroys all remote objects managed by a particular Terraform configuration.









