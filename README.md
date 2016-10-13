# Infra

A project detailing my personal infrastructure.

## Pre-requesites
- A DigitalOcean account 
- (DigitalOcean command-line tool `brew install doctl` for debugging)
- Terraform `brew install terraform`

## Usage

```bash
$ ./init.sh       # Setup terraform variables with secrets
$ terraform init
$ terraform get   # Register the modules
$ terraform plan  # Show the resulting infrastructure plan
$ terraform apply # Create the necessary infrastructure
```

