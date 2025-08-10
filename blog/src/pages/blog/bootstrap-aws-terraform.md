---
layout: ../../layouts/ArticleLayout.astro
title: "homelab[0] - bootstrapping aws & terraform"
date: July 28, 2025
---

This is the first article in a series documenting the deployment of my homelab. It's part '0' because 0 is the only proper index base (looking at you Lua) and this isn't quite yet setting up the homelab. The following is how I boostrap AWS with Terraform to acheive my own set of 'sane defaults'. Namely:

- Creating proper access-level users in IAM
- Creating AWS users for CI/CD pipelines
- Creating S3 Bucket & DynamoDB Table for Terraform State storage
- Creating general budgets with notifications

## step 1: create an account

Visit [AWS's signup page](https://signin.aws.amazon.com/signup) to
create an account. I reccommend having a dedicated email for
all-things development. Now would be an opportunity to use one.

## step 2: enable mfa

Once logged in, click your username in the top right-hand corner of the homepage and select "Security credentials".
Scroll down and click "Assign MFA device". Follow the steps to secure your account with either a 2FA app or, my
prefered method, a physical security key such as a
[YubiKey](https://en.wikipedia.org/wiki/YubiKey).

## step 3: get security credentials

Back in the "Security credentials" page, scroll to "Access keys" and press
"Create access key". You'll be given two keys: an "Access key ID" and a "Secret
access key". We will be using these in the next step.

## step 4: setup the cli

I like to minimize two particular things in my setup:

1. The amount of time spent in the browser
2. The amount of actions performed as the root-user

Steps performed in the browser are largely un-reproducable and thus hard to debug after the fact.
Using the root-user is against the precendent of [least privledge principle](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)

Let's install awscli. It's AWS's **\_\_**. There are [binaries available to
download](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) but I prefer to install it with my package manager
of choice: Homebrew.

```bash
brew install awscli
```

Next, we configure awscli to use the root user credentials we generated in the
browser.

```bash
aws configure
```

This command will prompt you to enter 4 things:

- Access key ID (created in step 4)
- Secret access key (also created in step 4)
- default region name ([full list
  here](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.RegionsAndAvailabilityZones.html).
  When in doubt, use 'us-east-1')
- default output format (either 'json', 'text', or 'table'. I prefer 'json'.
  #TODO: Why JSON?)

## step 5: create an administrative user

Now that awscli is setup, let's use it to create a replacement user going
forward.

A brief aside: AWS has three types of identities: users, groups, and roles.
Think of users as individual accounts with their own set of persistent credentials.
Groups are a collection of users that share the same type of permissions.
Roles are similar to users, but are instead `assumed` by AWS services or other entities.
For example, an EC2 instance can `assume` a role to gain access to a S3 bucket.
This role has a temporary set of credentials that are automatically rotated by AWS.
Roles are also great for CI/CD pipelines and lambda functions, where a dedicated user isn't needed.

In our case, we'll be creating a user named 'admin'.

```bash
aws iam create-user --user-name admin
```

## step 6: assigning permissions

With the user created, we can now assign it permissions. We'll give this user Administrator Access. The main difference between this and
the root user is that the latter can access billing options and close the
account.

Permissions are assigned by one of two ways:

1. Attaching a **managed** policy to the user
2. Creating an **inline** policy and attaching it to the user

In most cases, I prefer the former. It's more declarative which makes it easier to debug permission errors. It's also more reproducible, which makes it easier to scale to multiple identities.
Managed policies are declared in a .json file as seen below.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AdministratorAccess",
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
```

Every policy document includes version (the latest being '2012-10-17') and a statement body containing all statements of the policy.
Each statement defines **\_\_\_\_**. Statements are comprised of a:

1. Sid
   Optional, but reccommend to identify the **\_**)

2. Effect
   Denotes whether to Allow or Deny the Action (see below). The default value is "Deny".

3. Action/NotAction
   Which API calls an indentity (user, group, or role) are allowed/denied to make. Something to note is that the behaviour of "NotAction" depends on "Effect".
   For example, `NotAction` + `Allow` = all API calls except for those in NotAction. Whereas `NotAction` + `Deny` = Denies all API calls except those in NotAction

4. Resource/NotResource
   Specifies which AWS resource(s) this statement applies to. This specifcied by it's 'ARN' or 'Amazon Resource Name'. ARN's are unique strings with the following format:
   `arn:partition:service:region:account-id:resource`. Take for example,
   `arn:aws:ec2:us-west-2:123456789876:instance/i-1234567890abcdef0`.
   Some AWS resources are global or region-indpendent, in which case the region and account-id are omitted.
   Example: `arn:aws:s3:::my-example-bucket`

Let's create a new policy with the above `policy.json` file.

```bash
aws iam create-policy --policy-name AdministratorAccess --policy-document file://policy.json
```

Next, we assign this policy to the admin user we just created. We can do this by fetching our AWS account ID and using it to construct the policy's ARN.

```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
POLICY_NAME="AdministratorAccess"
POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/${POLICY_NAME}"

aws iam attach-user-policy --user-name admin --policy-arn $POLICY_ARN
```

Alternatively, we can attach the policy inline. Inline policies are premade policies that are directly attached to an AWS identity.
AWS provides an identical policy to the one we created above, so we can use that instead.

```bash
aws iam attach-user-policy --user-name admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

# step 7: generating access keys

Next, we create a pair of access keys for our admin user like we did for the root user. This time, we can do it through the terminal.

```bash
aws iam create-access-key --user-name admin
```

This returns a JSON object with the `AccessKeyId` and `SecretAccessKey` for our admin user.
Save these keys somewhere safe. The secret key will not be retrievable again.
We'll use these keys to configure AWS CLI to use our admin user.

```bash
aws configure --profile admin
```

This is the same proccess as before. This time, we use the `--profile` flag to create a new profile named `admin`.
Profiles in AWS CLI allow you to use multiple sets of credentials.

We can confirm that the admin user was created successfully by running:

```bash
aws sts get-caller-identity --user-name admin
```

## step 8: setting up a default profile

Right now, we have two profiles: `default` and `admin`. The `default` profile is the one we configured with the root user credentials.
We can set the `admin` profile as the default by exporting the `AWS_PROFILE` environment variable to our shell. Put the following line in your shell's config file. For myself, this is `~/.zshrc`.

```bash
export AWS_PROFILE=admin
```

Source the file to apply the changes:

```bash
source ~/.zshrc
```

## step 9: creating a role for github actions

We can give Github Actions permissions to our AWS account by creating a role. This role will be assumed by Github Action's OIDC provider.
OIDC stands for OpenID Connect. It's an authentication protocol without need for permanent credentials. It does this by using short-lived tokens signed by a trusted authority. In this case, the authority is Github Actions.
I prefer using OIDC over Github repo secrets because it eliminates one more place where a set of keys are stored. That's one less place to worry about leaking credentials or forgetting to rotate them.

First, let's create a openid connect provider. This tells AWS to trust tokens issued by Github Actions.

```bash
aws iam create-openid-connect-provider --url https://token.actions.githubusercontent.com --client-id-list sts.amazonaws.com
```

We can verify that the provider was created successfully by running:

```bash
aws sts get-caller-identity --query Account --output text
```

The response should be your AWS account ID.

Next, we need to create a trust policy that allows Github Actions to assume the role.

```json
/* trust-policy.json */
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::YOUR-AWS-ACCOUNT-ID:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:sub": "repo:YOUR-GITHUB-USERNAME/YOUR-REPO-NAME:ref:refs/heads/main",
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
```

Don't forget to replace `YOUR-AWS-ACCOUNT-ID`, `YOUR-GITHUB-USERNAME`, and `YOUR-REPO-NAME` with your actual values.
This policy lets Github Actions assume the role when your workflow runs on the `main` branch of your repository. Alternatively, you can change the `ref` to match your desired branch.

Next, we create a role to assume the trust policy we just created.

```bash
aws iam create-role\
  --role-name github-actions-role\
  --assume-role-policy-document file://trust-policy.json
```

Once created, we can attach the policy we created earlier to this role.

```bash
aws iam attach-role-policy\
  --role-name github-actions-role\
  --policy-arn $POLICY_ARN
```

Alternatively, you can use a new policy defined in a different `policy.json` file.

```bash
aws iam put-role-policy \
  --role-name github-actions-role \
  --policy-name github-actions-inline \
  --policy-document file://policy.json
```

Now that the role is created and a policy is attached to it, we can use it in Github Actions.
In your YAML file of choice, enter the following:

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v4
  with:
    role-to-assume: arn:aws:iam::YOUR-ACCOUNT-ID:role/github-actions-role
    aws-region: us-east-1
```

Now, when your Github Actions workflow runs, it will assume the `github-actions-role` role and have access to the permissions defined in the attached policy.

## step 10: bootstrapping terraform

Great. Now we have an admin user to use locally and a role for Github Actions to use. Let's bootstrap Terraform to manage our AWS resources.
First, [create a HashiCorp Cloud account](https://portal.cloud.hashicorp.com/sign-up). This is where we'll store our Terraform state file and manage our `workspaces`. Each workspace represents a separate environment (ex. `dev`, `staging`, or `prod`).

Next, install Terraform.

```bash
brew install terraform
```

Then, login with our HashiCorp Cloud account.

```bash
terraform login
```

This will prompt you to open a browser and authenticate with your HashiCorp Cloud account. Once authenticated, it will generate an API token and store it in your local machine.

With our credentials set up, we can start using Terraform.

I first set up a `provider.tf` file to define the AWS provider and configure it to use our HashiCorp Cloud account.

Creating the file:

```bash
touch provider.tf
```

Then, we can add the following code to the `provider.tf` file:

```hcl
terraform {
  cloud {
    organization = "your-org-name"
    workspaces {
      name = "your-workspace-name"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
```

This code defines the Terraform Cloud organization and workspace we want to use, as well as the AWS provider we want to use. Make sure to replace `your-org-name` and `your-workspace-name` with your actual values.

Once the `provider.tf` file is created, we can initialize Terraform to download the required providers and set up the backend for our state file.

```bash
terraform init
```

HERE

---

From here, we can start defining our AWS resources in separate `.tf` files. For example, we can create a `s3.tf` file to define an S3 bucket for storing our Terraform state file.

I find this workflow to be a good starting point for bootstrapping AWS and Terraform. It satisfies my desire for a 100% declarative setup without relying on the browser.
Next steps after architeching your project's infrastructure would include:

- Using Cloudwatch to see which permissions are used and refining your policies to use the [least privilege principle](https://en.wikipedia.org/wiki/Principle_of_least_privilege).
- Dividing your terrfaorm code into modules to make it more reusable and maintainable.
- Possibly migrating your statefile to a remote backend like S3 with DynamoDB for locking.

Either way, I hope this guide helps you get started with bootstrapping AWS and Terraform in a way that aligns with your own sane defaults.
