# GCP + Workload Identity + Github Actions + Terraform = 💗

Hello there 👋 This terraform project was bootstrapped using gabileibo/gcp-terraform-actions-template

## About this repo

A simple repo to help bootstrap a Terraform project to provision infrastructure on GCP using Github Actions with workload identity. OIDC allows "keyless" entry from Github Actions to GCP.

Read more about how this works [here](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)

In practice I usually run the `pipeline-admin` folder locally to provision the minimum amount of access needed for this particular repository's purpose so that the rest of the team can use it for just what it is intended for.

## Prerequisites

1. A GCP Project

2. A GitHub Account

3. Terraform, [gh cli](https://cli.github.com/), and [gcloud cli](https://cloud.google.com/sdk/gcloud#download_and_install_the) installed on your machine

4. Install [tfsec](https://aquasecurity.github.io/tfsec), [terraform_docs](https://terraform-docs.io/), and [pre-commit](https://pre-commit.com/) for some out-of-the-box best practice good-ness

## What will this Boilerplate do?

1. Automatically setup a GCS Bucket to store tf state

2. Setup a new Github Repo, with Action Workflows and environments all set up

3. Create 2 types of service accounts, one that has readonly permissions for running `terraform plan` for your PRs and one that has read+write permissions for running `terraform apply`, the later only being enabled when deploying to the default branch (i.e. main).

4. Sets up a GCP Workload Identity Pool to allow the Github Action runners to authenticate as your service accounts without the need for keys

## Usage

1. Make sure you are authenticated `gh auth login` and `gcloud auth application-default login` (you must be the project owner during the setup run).

2. fill in the variables in init.sh and run `sh init.sh`

3. fill in the template variables in `terraform.tfvars` and `providers.tf` and run:

```
cd pipeline
export GITHUB_TOKEN=$(gh auth token)
# If you want to set this up for a GitHub org then run `export GITHUB_OWNER=<my-org-id>`
terraform init
terraform plan
terraform apply
cd ..
```

4. Now point the remote origin to the Github repo you just created using terraform, commit/push to main, and watch the magic happen 😎

```
git remote set-url origin https://github.com/<my-new-repo>
git add .
git commit -m "init pipeline"
git push -u origin master
```

5. If everything was set up correctly, the pipeline should succeed and you should see a the `bootstrap.txt` message in your terraform apply outputs

## Bonus

- Try adding customer supplied encryption keys to your state files
